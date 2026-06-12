// To parse this JSON data, do
//
//     final getFavoriteUserListModel = getFavoriteUserListModelFromJson(jsonString);

import 'dart:convert';

GetFavoriteUserListModel getFavoriteUserListModelFromJson(String str) =>
    GetFavoriteUserListModel.fromJson(json.decode(str));

String getFavoriteUserListModelToJson(GetFavoriteUserListModel data) =>
    json.encode(data.toJson());

class GetFavoriteUserListModel {
  bool? success;
  String? message;
  Result? result;

  GetFavoriteUserListModel({this.success, this.message, this.result});

  factory GetFavoriteUserListModel.fromJson(Map<String, dynamic> json) =>
      GetFavoriteUserListModel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  Meta? meta;
  List<LikedUserList>? data;

  Result({this.meta, this.data});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null
        ? []
        : List<LikedUserList>.from(
            json["data"]!.map((x) => LikedUserList.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LikedUserList {
  LikeReceive? likeReceive;

  LikedUserList({this.likeReceive});

  factory LikedUserList.fromJson(Map<String, dynamic> json) => LikedUserList(
    likeReceive: json["LikeReceive"] == null
        ? null
        : LikeReceive.fromJson(json["LikeReceive"]),
  );

  Map<String, dynamic> toJson() => {"LikeReceive": likeReceive?.toJson()};
}

class LikeReceive {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? profileImage;
  String? phoneNumber;
  DateTime? lastActivateAt;
  int? isOnline;

  LikeReceive({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.profileImage,
    this.phoneNumber,
    this.lastActivateAt,
    this.isOnline,
  });

  factory LikeReceive.fromJson(Map<String, dynamic> json) => LikeReceive(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    role: json["role"],
    profileImage: json["profileImage"],
    phoneNumber: json["phoneNumber"],
    lastActivateAt: json["lastActivateAt"] == null
        ? null
        : DateTime.parse(json["lastActivateAt"]),
    isOnline: json["isOnline"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "role": role,
    "profileImage": profileImage,
    "phoneNumber": phoneNumber,
    "lastActivateAt": lastActivateAt?.toIso8601String(),
    "isOnline": isOnline,
  };
}

class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Meta({this.total, this.page, this.limit, this.totalPages});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}
