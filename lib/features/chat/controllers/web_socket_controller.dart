import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/chat/controllers/chat_controller.dart';
import 'package:quick_job/features/chat/controllers/individual_chat_controller.dart';
import 'package:quick_job/features/chat/models/conversation_list_model.dart';
import 'package:web_socket_channel/io.dart';

class SocketController extends GetxController with WidgetsBindingObserver {
  late IOWebSocketChannel channel;
  final currentCallPartnerId = "".obs;
  final isTyping = false.obs;
  final showError = true.obs;

  final lastDeliveredMessageId = Rx<String?>(null);
  final lastSeenMessageId = Rx<String?>(null);

  final chatRoomId = Rx<String?>(null);
  bool _chatRoomInitialized = false;

  // Timer? _typingTimer;

  // ---------------- STATE ----------------
  final isConnected = false.obs;
  final privateMessageReceived = Rx<Map<String, dynamic>?>(null);
  final lastMessageStatusReceived = Rx<Map<String, dynamic>?>(null);

  Timer? _pingTimer;
  int _retryCount = 0;

  static const int _maxRetry = 5;
  String? _activeChatUserId; // current joined private chat

  // ---------------- INIT ----------------
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    connect();
    super.onInit();
  }

  // ---------------- CONNECT ----------------
  void connect() {
    try {
      channel = IOWebSocketChannel.connect(
        Uri.parse(AppUrls.webSocket),
        headers: {"x-token": AuthService.token ?? ""},
      );

      channel.stream.listen(
        _onMessage,
        onDone: _onDisconnect,
        onError: _onError,
      );

      isConnected.value = true;
      _retryCount = 0;

      // _startHeartbeat();
      joinApp();

      log("✅ WS Connected");
    } catch (e) {
      log("❌ WS Connect error: $e");
      _scheduleReconnect();
    }
  }

  // ---------------- MESSAGE LISTENER ----------------
  void _onMessage(dynamic event) {
    log("📩 WS: $event");

    try {
      final Map<String, dynamic> data = jsonDecode(event);
      final String? type = data['type'];

      switch (type) {
        case 'receivePrivateMessage':
          // Incoming message
          privateMessageReceived.value = data;

          // Auto send delivered
          // sendMessageDelivered(data['id'], data['senderId']);
          break;
        case 'last_message_seen':
          lastMessageStatusReceived.value = data;
          AppLoggerHelper.info("message status get done");

        case 'messageDelivered':
          lastDeliveredMessageId.value = data['messageId'];
          log("✅ Delivered: ${data['messageId']}");
          break;

        case 'messageSeen':
          lastSeenMessageId.value = data['messageId'];
          log("👁️ Seen: ${data['messageId']}");
          break;

        case 'typing':
          isTyping.value = data['isTyping'] ?? false;
          break;

        case 'pong':
          log("💓 Pong");
          break;
        case 'joinPrivateChat':
          final String? roomId = data['chatroomId'];

          if (roomId != null && roomId.isNotEmpty && !_chatRoomInitialized) {
            _chatRoomInitialized = true;
            chatRoomId.value = roomId;

            log("🟢 ChatRoom joined: $roomId");

            _fetchInitialChat(roomId);
          }
          break;

        case 'conversationList':
          final chatController = Get.find<ChatController>();
          final RxList<Conversation> conversationList =
              chatController.conversationListData;

          final dynamic result = data['result'];

          // result could be List or Map
          List<dynamic> conversations = [];

          if (result is Map<String, dynamic>) {
            conversations = result['conversations'] ?? [];
          } else if (result is List) {
            conversations = result;
          }

          for (var convJson in conversations) {
            final myId = AuthService.id.toString();

            if (convJson['participants']?['id'] == myId) {
              continue;
            }

            if (convJson['messageIndicator'] == 'stay') {
              final String conversationId = convJson['conversationId'];

              final int idx = conversationList.indexWhere(
                (c) => c.conversationId == conversationId,
              );
              if (idx != -1) {
                conversationList[idx] = Conversation.fromJson(convJson);
              }
              continue;
            }

            if (convJson['messageIndicator'] != 'up') continue;

            final Conversation newConv = Conversation.fromJson(convJson);

            final int index = conversationList.indexWhere(
              (c) => c.conversationId == newConv.conversationId,
            );

            if (index != -1) {
              conversationList.removeAt(index);
            }

            conversationList.insert(0, newConv);
          }

          conversationList.refresh();
          break;

        default:
          log("ℹ️ Unknown WS type: $type");
      }
    } catch (e) {
      log("❌ WS parse error: $e");
    }
  }

  //-----------------INDICATOR-----------------
  // void sendMessageDelivered(String messageId, String user2Id) {
  //   if (!isConnected.value) return;

  //   send({
  //     "type": "messageDelivered",
  //     "messageId": messageId,
  //     "user2Id": user2Id,
  //   });

  //   log("📬 Delivered sent for $messageId");
  // }

  // void sendMessageSeen(String messageId, String user2Id) {
  //   if (!isConnected.value) return;

  //   send({"type": "messageSeen", "messageId": messageId, "user2Id": user2Id});

  //   log("👁️ Seen sent for $messageId");
  // }

  // void sendTyping(bool typing) {
  //   if (!isConnected.value || _activeChatUserId == null) return;

  //   send({"type": "typing", "user2Id": _activeChatUserId, "isTyping": typing});

  //   if (typing) {
  //     _typingTimer?.cancel();
  //     _typingTimer = Timer(const Duration(seconds: 2), () {
  //       sendTyping(false);
  //     });
  //   }
  // }

  // // ---------------- HEARTBEAT ----------------
  // void _startHeartbeat() {
  //   _pingTimer?.cancel();
  //   _pingTimer = Timer.periodic(const Duration(seconds: 20), (_) {
  //     if (isConnected.value) {
  //       send({"type": "ping"});
  //     }
  //   });
  // }

  // ---------------- SEND CORE ----------------
  void send(Map<String, dynamic> data) {
    if (!isConnected.value) {
      log("⚠️ WS not connected");
      return;
    }
    channel.sink.add(jsonEncode(data));
  }

  // ---------------- JOIN APP ----------------
  void joinApp() {
    send({"type": "joinApp"});
    log("✅ Joined app socket");
  }

  // ---------------- JOIN PRIVATE CHAT ----------------
  // void joinPrivateChat(String user2Id) {
  //   if (!isConnected.value) return;

  //   _activeChatUserId = user2Id;
  //   _chatRoomInitialized = false;

  //   send({"type": "joinPrivateChat", "user2Id": user2Id});

  //   log("✅ Joined private chat with $user2Id");
  // }

  Future<void> joinPrivateChat(String user2Id) async {
    if (!isConnected.value) return;

    // 🔴 OLD CHAT CLEANUP
    // if (_activeChatUserId != null && _activeChatUserId != user2Id) {
    //   leavePrivateChat();
    // }

    // 🔁 RESET STATE
    chatRoomId.value = null;
    _chatRoomInitialized = false;

    _activeChatUserId = user2Id;

    send({"type": "joinPrivateChat", "user2Id": user2Id});

    log("✅ Joining private chat with $user2Id");
  }

  // ---------------- LEAVE PRIVATE CHAT ----------------
  void leavePrivateChat() {
    if (!isConnected.value || _activeChatUserId == null) return;

    send({"type": "leavePrivateChat", "user2Id": _activeChatUserId});

    log("👋 Left private chat with $_activeChatUserId");
    _activeChatUserId = null;
  }

  // ---------------- LEAVE PRIVATE CHAT ----------------
  void leavePrivateChatTrigger() {
    if (!isConnected.value) return;

    send({"type": "leavePrivateChat"});

    log("👋 Left private chat");
    _activeChatUserId = null;
  }

  // ---------------- SEND PRIVATE MESSAGE ----------------
  void sendPrivateMessage({
    required String user2Id,
    required String message,
    String? imgUrl,
    // String? emojiId,
    required String messageType, // text / image / voice
  }) {
    if (!isConnected.value) {
      log("⚠️ Message not sent, socket disconnected");
      return;
    }

    send({
      "type": "sendPrivateMessage",
      "receiverId": user2Id,
      "content": message,
      "imageUrl": imgUrl ?? "",
      "messageType": messageType,
      // "emojiId": emojiId ?? "",
    });

    log("📤 Message sent to $user2Id | type: $messageType");
  }

  // ---------------- DISCONNECT ----------------
  void _onDisconnect() {
    log("⚠️ WS Disconnected");
    _cleanup();
    _scheduleReconnect();
  }

  void _onError(dynamic e) {
    log("❌ WS Error: $e");
    _cleanup();
    _scheduleReconnect();
  }

  // ---------------- RECONNECT ----------------
  void _scheduleReconnect() {
    if (_retryCount >= _maxRetry) {
      log("🚫 Max reconnect reached");
      return;
    }

    _retryCount++;
    final delay = Duration(seconds: _retryCount * 3);

    log("🔄 Reconnecting in ${delay.inSeconds}s");
    Future.delayed(delay, connect);
  }

  // ---------------- LIFECYCLE ----------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!isConnected.value) {
        connect();
      }
    } else if (state == AppLifecycleState.paused) {
      disconnect();
    }
  }

  Future<void> _fetchInitialChat(String roomId) async {
    try {
      log("📡 Fetching chat history for room: $roomId");
      final chatController = Get.find<IndividualChatController>();
      await chatController.getConversationDetails(
        roomId: roomId,
        isRefresh: true,
      );
      chatController.chatroomId.value = roomId;
      AppLoggerHelper.info(
        "chatroomId is : ${chatController.chatroomId.value}",
      );
    } catch (e) {
      log("❌ Chat history fetch failed: $e");
    }
  }

  // ---------------- CLEANUP ----------------
  void disconnect() {
    _cleanup();
    channel.sink.close();
  }

  void _cleanup() {
    isConnected.value = false;
    _pingTimer?.cancel();
  }

  // ---------------- DISPOSE ----------------
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    disconnect();
    super.onClose();
  }
}
