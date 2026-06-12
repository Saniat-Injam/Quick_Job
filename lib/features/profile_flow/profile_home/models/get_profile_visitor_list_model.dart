// To parse this JSON data, do
//
//     final getProfileVisitionUserListModel = getProfileVisitionUserListModelFromJson(jsonString);

import 'dart:convert';

GetProfileVisitionUserListModel getProfileVisitionUserListModelFromJson(String str) => GetProfileVisitionUserListModel.fromJson(json.decode(str));

String getProfileVisitionUserListModelToJson(GetProfileVisitionUserListModel data) => json.encode(data.toJson());

class GetProfileVisitionUserListModel {
    bool? success;
    String? message;
    Result? result;

    GetProfileVisitionUserListModel({
        this.success,
        this.message,
        this.result,
    });

    factory GetProfileVisitionUserListModel.fromJson(Map<String, dynamic> json) => GetProfileVisitionUserListModel(
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
    List<ProfileVisitorInfo>? data;

    Result({
        this.meta,
        this.data,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<ProfileVisitorInfo>.from(json["data"]!.map((x) => ProfileVisitorInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ProfileVisitorInfo {
    ProfileViewer? profileViewer;

    ProfileVisitorInfo({
        this.profileViewer,
    });

    factory ProfileVisitorInfo.fromJson(Map<String, dynamic> json) => ProfileVisitorInfo(
        profileViewer: json["ProfileViewer"] == null ? null : ProfileViewer.fromJson(json["ProfileViewer"]),
    );

    Map<String, dynamic> toJson() => {
        "ProfileViewer": profileViewer?.toJson(),
    };
}

class ProfileViewer {
    String? id;
    String? fullName;
    String? email;
    String? role;
    String? profileImage;
    String? phoneNumber;
    DateTime? updatedAt;
    DateTime? lastActivateAt;
    int? isOnline;
    List<dynamic>? likeReceive;

    ProfileViewer({
        this.id,
        this.fullName,
        this.email,
        this.role,
        this.profileImage,
        this.phoneNumber,
        this.updatedAt,
        this.lastActivateAt,
        this.isOnline,
        this.likeReceive,
    });

    factory ProfileViewer.fromJson(Map<String, dynamic> json) => ProfileViewer(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        profileImage: json["profileImage"],
        phoneNumber: json["phoneNumber"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        lastActivateAt: json["lastActivateAt"] == null ? null : DateTime.parse(json["lastActivateAt"]),
        isOnline: json["isOnline"],
        likeReceive: json["likeReceive"] == null ? [] : List<dynamic>.from(json["likeReceive"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "role": role,
        "profileImage": profileImage,
        "phoneNumber": phoneNumber,
        "updatedAt": updatedAt?.toIso8601String(),
        "lastActivateAt": lastActivateAt?.toIso8601String(),
        "isOnline": isOnline,
        "likeReceive": likeReceive == null ? [] : List<dynamic>.from(likeReceive!.map((x) => x)),
    };
}

class Meta {
    int? total;
    int? page;
    int? limit;
    int? totalPages;

    Meta({
        this.total,
        this.page,
        this.limit,
        this.totalPages,
    });

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
