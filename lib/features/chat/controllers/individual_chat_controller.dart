import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/features/chat/controllers/chat_controller.dart';
import 'package:quick_job/features/chat/controllers/web_socket_controller.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../models/individual_chat_message_model.dart';
import 'package:http/http.dart' as http;

class IndividualChatController extends GetxController {
  final messageController = TextEditingController();

  String userId = '';
  String username = '';
  String image =
      'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg';
  final chatroomId = ''.obs;
  final isLiked = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      userId = Get.arguments["userId"] ?? '';
      isLiked.value = Get.arguments["isLiked"] ?? false;
      username = Get.arguments["username"] ?? 'Unknown';
      image =
          Get.arguments["image"] ??
          'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg';
      // chatroomId2 = Get.arguments["chatroomId"] ?? '';
      AppLoggerHelper.info("Opening chat with user: $username (ID: $userId)");

      // getConversationDetails(isRefresh: true, roomId: chatroomId);

      joinChat(user2Id: userId);

      scrollController.addListener(_scrollListener);
    } else {
      AppLoggerHelper.error(
        "No arguments provided to IndividualChatController",
      );
    }

    ever(socketController.privateMessageReceived, (data) {
      log("privateMessageReceived triggered with data: $data");
      AppLoggerHelper.debug(data.toString());

      if (data == null) return;

      final String? msgConversationId = data['conversationId'];
      if (msgConversationId != socketController.chatRoomId.value) {
        log("Message for different conversation, ignoring");
        return;
      }

      final receivedMessage = ChatMessage.fromJson(data);

      // messages.first.messageStatus = "seen";
      // if ("isUpdate" == "isUpdate") {
      //   messages.removeAt(0);
      // }

      messages.insert(0, receivedMessage);
      log(
        "New message: ${receivedMessage.imageUrl ?? receivedMessage.content}",
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
    // ever(socketController.lastMessageStatusReceived, (data) {
    //   if (data?['result'] == true) {
    //     log("result is true");
    //     messages.first.messageStatus = "seen";
    //   }
    //   messages.refresh();
    // });
    ever(socketController.lastMessageStatusReceived, (data) {
      if (data?['result'] == true) {
        for (final msg in messages) {
          if (msg.senderId == AuthService.id && msg.messageStatus != "seen") {
            msg.messageStatus = "seen";
            log("I am loop :");
          }
        }

        messages.refresh();
      }
    });

    scrollController.addListener(_scrollListener);
  }

  // for pagination
  final scrollController = ScrollController();

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  final ImagePicker picker = ImagePicker();
  final imagePath = "".obs;
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    imagePath.value = image.path;
  }

  final socketController = Get.find<SocketController>();
  Future<void> joinChat({required String user2Id}) async {
    isUserLoading.value = true;
    await socketController.joinPrivateChat(user2Id);
    isUserLoading.value = false;
  }

  final isLoadImage = false.obs;
  Future<void> sendSms({required String type}) async {
    if ((messageController.text.trim().isEmpty && imagePath.value.isEmpty) ||
        userId.isEmpty) {
      messageController.text = "";
      log("I am here");
      return;
    }
    log("I am : ${messageController.text}");
    log("user id : ${userId}");
    if (imagePath.value.isEmpty) {
      log("user id : $userId");
      log("conversation id : $chatroomId");
      socketController.sendPrivateMessage(
        user2Id: userId,
        message: messageController.text,
        messageType: type,
      );
      messageController.clear();
    } else {
      isLoadImage(true);
      await uploadImg();
      log("Iam hear ====================");
      log("Response url data is : ${responseUrl.isEmpty}");
      if (responseUrl.isEmpty) {
        AppSnackBar.showError("Image upload failed");
        isLoadImage(false);
        responseUrl = "";
        imagePath.value = "";
        return;
      }

      socketController.sendPrivateMessage(
        user2Id: userId,
        message: messageController.text,
        messageType: type,
        imgUrl: responseUrl,
      );
      log("Iam hear signal time socket call");
      messageController.clear();
      responseUrl = "";
      imagePath.value = "";
      isLoadImage(false);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // uploade img
  String responseUrl = "";
  // shear a img
  Future<void> uploadImg() async {
    try {
      log("Api hit");
      if (imagePath.isEmpty) return;
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(AppUrls.uploadImage),
      );

      // Headers
      request.headers['Authorization'] = 'Bearer ${AuthService.token}';
      request.headers['Accept'] = 'application/json';

      // Add image if exists
      if (imagePath.isNotEmpty) {
        final mimeType = lookupMimeType(imagePath.value) ?? "image/jpeg";
        final splitMime = mimeType.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            "chatImage",
            imagePath.value,
            contentType: MediaType(splitMime[0], splitMime[1]),
          ),
        );
      }

      // Send request
      final streamedResponse = await request.send();

      // Close dialog if open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Check status
      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        final responseBody = await streamedResponse.stream.bytesToString();
        final Map<String, dynamic> responseJson = jsonDecode(responseBody);

        responseUrl = '';

        if (responseJson['data'] is String) {
          responseUrl = responseJson['data'];
        } else if (responseJson['result'] is String) {
          responseUrl = responseJson['result'];
        }
        AppLoggerHelper.info("Image uploaded successfully: $responseUrl");
        log("URL is : $responseUrl");
      } else {
        final errorBody = await streamedResponse.stream.bytesToString();
        AppLoggerHelper.error("Upload failed: ${streamedResponse.statusCode}");
        AppLoggerHelper.error("Error response: $errorBody");
        AppSnackBar.showError("Image upload failed for serer side");
      }
    } catch (error) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppLoggerHelper.error("Upload exception: $error");
      AppSnackBar.showError("Something went wrong");
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels <=
            scrollController.position.maxScrollExtent + 200 &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      log("User scrolling UP to top - loading more old messages");

      if (!isLoadMore.value && hasMore) {
        getConversationDetails(roomId: chatroomId.value);
      }
    }
  }

  final isUserLoading = false.obs;
  final isLoadMore = false.obs;
  int totalPage = 1;
  int currantPage = 1;
  int limit = 20;
  bool hasMore = true;
  final messages = <ChatMessage>[].obs;
  // for get user all post
  Future<void> getConversationDetails({
    bool isRefresh = false,
    required String roomId,
  }) async {
    try {
      if (isRefresh) {
        currantPage = 1;
        hasMore = true;
        messages.clear();
      }
      if (!hasMore) return;
      if (currantPage == 1) {
        isUserLoading(true);
      } else {
        isLoadMore(true);
      }
      log("cahtroom id is : $roomId");

      final response = await NetworkCaller().getRequest(
        "${AppUrls.getMessageListForUser(conversationId: roomId)}?limit=$limit&page=$currantPage",
      );
      if (response.isSuccess) {
        log("post fetch successful! for $currantPage");
        final data = GetConversationDetails.fromJson(response.responseData);
        if (data.result != null && (data.result ?? []).isNotEmpty) {
          messages.addAll(data.result ?? []);
          currantPage = data.meta?.page ?? 0;
          totalPage = data.meta?.totalPage ?? 0;
          log("Current page is : $currantPage total page is : $totalPage");

          if (currantPage >= totalPage) {
            hasMore = false;
          } else {
            currantPage++;
            hasMore = true;
          }
        } else {
          hasMore = false;
        }
      } else {
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppLoggerHelper.error("Api Error : $e");
    } finally {
      isUserLoading(false);
      isLoadMore(false);
    }
  }

  // for send notification to others user
  Future<void> sendCallNotification({
    required bool callType,
    required String othersUserId,
  }) async {
    try {
      final body = {
        "title": callType ? "Video call" : "Audio call",
        "body": "Incoming call.....",
        "userId": othersUserId,
      };
      final response = await NetworkCaller().postRequest(
        AppUrls.sendCallNotification,
        body: body,
      );
      if (response.isSuccess) {
        AppLoggerHelper.info("Notification send successful");
      } else {
        AppLoggerHelper.error("Notification not send to user!");
      }
    } catch (e) {
      AppLoggerHelper.error("user not get notification");
    }
  }

  // for List or dislike user
  Future<void> likeOrUnLiked() async {
    try {
      loadingProgressIndicator();
      final response = await NetworkCaller().postRequest(
        AppUrls.likeOrUnlike(receiverUserId: userId),
        body: {},
      );

      if (response.isSuccess) {
        final data = response.responseData;
        final isLiked = data['result'];
        final chatController = Get.find<ChatController>();
        await chatController.getConversationList(isRefresh: true);
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.back();
        AppSnackBar.showSuccess(
          "${isLiked == "true" ? "Add" : "Remove"} to Favorite successful",
        );
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    }
  }
}
