// class NotificationModel {
//   final String title;
//   final String time;
//   final String? imageUrl;
//   final int colorCode;

//   NotificationModel({
//     required this.title,
//     required this.time,
//     this.imageUrl,
//     required this.colorCode,
//   });
// }


import 'dart:convert';

GetAllNotificationModel getAllNotificationModelFromJson(String str) =>
    GetAllNotificationModel.fromJson(json.decode(str));

String getAllNotificationModelToJson(GetAllNotificationModel data) =>
    json.encode(data.toJson());

class GetAllNotificationModel {
  bool? success;
  String? message;
  List<NotificationModel>? result;

  GetAllNotificationModel({
    this.success,
    this.message,
    this.result,
  });

  factory GetAllNotificationModel.fromJson(Map<String, dynamic> json) =>
      GetAllNotificationModel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<NotificationModel>.from(
                json["result"].map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class NotificationModel {
  String? id;
  String? receiverId;
  String? body;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.receiverId,
    this.body,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        receiverId: json["receiverId"],
        body: json["body"],
        title: json["title"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receiverId": receiverId,
        "body": body,
        "title": title,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
