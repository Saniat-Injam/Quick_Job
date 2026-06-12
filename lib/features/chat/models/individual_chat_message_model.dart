// enum MessageSender { me, other }

// class ChatMessage {
//   final String id;
//   final String text;
//   final DateTime time;
//   final MessageSender sender;

//   ChatMessage({
//     required this.id,
//     required this.text,
//     required this.time,
//     required this.sender,
//   });
// }

// To parse this JSON data, do
//
//     final getConversationDetails = getConversationDetailsFromJson(jsonString);

import 'dart:convert';

GetConversationDetails getConversationDetailsFromJson(String str) =>
    GetConversationDetails.fromJson(json.decode(str));

String getConversationDetailsToJson(GetConversationDetails data) =>
    json.encode(data.toJson());

class GetConversationDetails {
  bool? success;
  String? message;
  Meta? meta;
  List<ChatMessage>? result;

  GetConversationDetails({this.success, this.message, this.meta, this.result});

  factory GetConversationDetails.fromJson(Map<String, dynamic> json) =>
      GetConversationDetails(
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        result: json["result"] == null
            ? []
            : List<ChatMessage>.from(
                json["result"]!.map((x) => ChatMessage.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Meta {
  int? page;
  int? limit;
  int? totalPage;
  int? total;

  Meta({this.page, this.limit, this.totalPage, this.total});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    totalPage: json["totalPage"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalPage": totalPage,
    "total": total,
  };
}

class ChatMessage {
  String? id;
  String? senderId;
  String? receiverId;
  String? content;
  DateTime? createdAt;
  bool? read;
  DateTime? updatedAt;
  String? messageStatus;
  String? messageType;
  String? conversationId;
  String? imageUrl;

  ChatMessage({
    this.id,
    this.senderId,
    this.receiverId,
    this.content,
    this.createdAt,
    this.read,
    this.updatedAt,
    this.messageStatus,
    this.messageType,
    this.conversationId,
    this.imageUrl,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json["id"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    content: json["content"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    read: json["read"],
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    messageStatus: json["messageStatus"],
    messageType: json["messageType"],
    conversationId: json["conversationId"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "senderId": senderId,
    "receiverId": receiverId,
    "content": content,
    "createdAt": createdAt?.toIso8601String(),
    "read": read,
    "updatedAt": updatedAt?.toIso8601String(),
    "messageStatus": messageStatus,
    "messageType": messageType,
    "conversationId": conversationId,
    "imageUrl": imageUrl,
  };
}
