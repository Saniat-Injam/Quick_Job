class ChatMessageModel {
  final String sender;
  final String message;
  final String timestamp;
  final String avatarUrl;
  final bool isOnline;
  final String? conversationId;
  final String? userId;
  final int unseenCount;

  ChatMessageModel({
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.avatarUrl,
    this.isOnline = false,
    this.conversationId,
    this.userId,
    this.unseenCount = 0,
  });
}