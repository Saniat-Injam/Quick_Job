// // To parse this JSON data, do
// //
// //     final getConversationListModel = getConversationListModelFromJson(jsonString);

// import 'dart:convert';

// GetConversationListModel getConversationListModelFromJson(String str) =>
//     GetConversationListModel.fromJson(json.decode(str));

// String getConversationListModelToJson(GetConversationListModel data) =>
//     json.encode(data.toJson());

// class GetConversationListModel {
//   bool? success;
//   String? message;
//   Meta? meta;
//   List<Conversation>? result;

//   GetConversationListModel({
//     this.success,
//     this.message,
//     this.meta,
//     this.result,
//   });

//   factory GetConversationListModel.fromJson(Map<String, dynamic> json) =>
//       GetConversationListModel(
//         success: json["success"],
//         message: json["message"],
//         meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
//         result: json["result"] == null
//             ? []
//             : List<Conversation>.from(
//                 json["result"]!.map((x) => Conversation.fromJson(x)),
//               ),
//       );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "meta": meta?.toJson(),
//     "result": result == null
//         ? []
//         : List<dynamic>.from(result!.map((x) => x.toJson())),
//   };
// }

// class Meta {
//   int? page;
//   int? limit;
//   int? total;

//   Meta({this.page, this.limit, this.total});

//   factory Meta.fromJson(Map<String, dynamic> json) =>
//       Meta(page: json["page"], limit: json["limit"], total: json["total"]);

//   Map<String, dynamic> toJson() => {
//     "page": page,
//     "limit": limit,
//     "total": total,
//   };
// }

// class Conversation {
//   String? conversationId;
//   String? type;
//   Participants? participants;
//   String? lastMessage;
//   DateTime? lastMessageTime;
//   int? unseen;
//   String? messageStatus;
//   String? messageIndicator; // <-- add this
//   String? lastMessageUserId;

//   Conversation({
//     this.conversationId,
//     this.type,
//     this.participants,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.unseen,
//     this.messageStatus,
//     this.messageIndicator,
//     this.lastMessageUserId,
//   });

//   factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
//     conversationId: json["conversationId"],
//     type: json["type"],
//     participants: json["participants"] == null
//         ? null
//         : Participants.fromJson(json["participants"]),
//     lastMessage: json["lastMessage"],
//     lastMessageTime: json["lastMessageTime"] == null
//         ? null
//         : DateTime.parse(json["lastMessageTime"]),
//     unseen: json["unseen"],
//     messageStatus: json["messageStatus"],
//     messageIndicator: json["messageIndicator"], // <-- add
//     lastMessageUserId: json["lastMessageUserId"],
//   );

//   Map<String, dynamic> toJson() => {
//     "conversationId": conversationId,
//     "type": type,
//     "participants": participants?.toJson(),
//     "lastMessage": lastMessage,
//     "lastMessageTime": lastMessageTime?.toIso8601String(),
//     "unseen": unseen,
//     "messageStatus": messageStatus,
//     "messageIndicator": messageIndicator, // <-- add
//     "lastMessageUserId": lastMessageUserId,
//   };
// }

// class Participants {
//   String? userId;
//   String? username;
//   String? image;
//   String? isOnline;
//   DateTime? lastActivateAt;

//   Participants({
//     this.userId,
//     this.username,
//     this.image,
//     this.isOnline,
//     this.lastActivateAt,
//   });

//   factory Participants.fromJson(Map<String, dynamic> json) => Participants(
//     userId: json["userId"],
//     username: json["username"],
//     image: json["image"],
//     isOnline: json["isOnline"],
//     lastActivateAt: json["lastActivateAt"] == null
//         ? null
//         : DateTime.parse(json["lastActivateAt"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "username": username,
//     "image": image,
//     "isOnline": isOnline,
//     "lastActivateAt": lastActivateAt?.toIso8601String(),
//   };
// }

import 'dart:convert';

GetConversationListModel getConversationListModelFromJson(String str) =>
    GetConversationListModel.fromJson(json.decode(str));

String getConversationListModelToJson(GetConversationListModel data) =>
    json.encode(data.toJson());

class GetConversationListModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Conversation>? result;

  GetConversationListModel({
    this.success,
    this.message,
    this.meta,
    this.result,
  });

  factory GetConversationListModel.fromJson(Map<String, dynamic> json) =>
      GetConversationListModel(
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        result: json["result"] == null
            ? []
            : List<Conversation>.from(
                json["result"].map((x) => Conversation.fromJson(x)),
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
  int? total;

  Meta({this.page, this.limit, this.total});

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(page: json["page"], limit: json["limit"], total: json["total"]);

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
  };
}

class Conversation {
  String? conversationId;
  String? type;
  Participants? participants;
  String? lastMessage;
  DateTime? lastMessageTime;
  int? unseen;
  String? messageStatus;
  String? lastMessageUserId;

  Conversation({
    this.conversationId,
    this.type,
    this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.unseen,
    this.messageStatus,
    this.lastMessageUserId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    conversationId: json["conversationId"],
    type: json["type"],
    participants: json["participants"] == null
        ? null
        : Participants.fromJson(json["participants"]),
    lastMessage: json["lastMessage"],
    lastMessageTime: json["lastMessageTime"] == null
        ? null
        : DateTime.parse(json["lastMessageTime"]),
    unseen: json["unseen"],
    messageStatus: json["messageStatus"],
    lastMessageUserId: json["lastMessageUserId"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "type": type,
    "participants": participants?.toJson(),
    "lastMessage": lastMessage,
    "lastMessageTime": lastMessageTime?.toIso8601String(),
    "unseen": unseen,
    "messageStatus": messageStatus,
    "lastMessageUserId": lastMessageUserId,
  };
}

class Participants {
  String? userId;
  String? username;
  String? image;
  String? isOnline;
  DateTime? lastActivateAt;
  bool? isLike;

  Participants({
    this.userId,
    this.username,
    this.image,
    this.isOnline,
    this.lastActivateAt,
    this.isLike,
  });

  factory Participants.fromJson(Map<String, dynamic> json) {
    // image clean
    String? img = json["image"];
    if (img != null) {
      img = img.trim();
      if (img.isEmpty) img = null;
    }

    // lastActivateAt clean
    DateTime? lastActive;
    if (json["lastActivateAt"] != null) {
      try {
        lastActive = DateTime.parse(json["lastActivateAt"]);
      } catch (e) {
        lastActive = null;
      }
    }

    return Participants(
      userId: json["userId"] ?? json["id"],
      username: json["username"],
      image: img,
      isOnline: json["isOnline"],
      lastActivateAt: lastActive,
      isLike: json['isLike'],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "image": image,
    "isOnline": isOnline,
    "isLike": isLike,
    "lastActivateAt": lastActivateAt?.toIso8601String(),
  };
}
