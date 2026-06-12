import 'dart:convert';

EmployerEditProfileModel employerEditProfileModelFromJson(String str) =>
    EmployerEditProfileModel.fromJson(json.decode(str));

String employerEditProfileModelToJson(EmployerEditProfileModel data) =>
    json.encode(data.toJson());

class EmployerEditProfileModel {
  bool? success;
  String? message;
  Result? result;

  EmployerEditProfileModel({this.success, this.message, this.result});

  factory EmployerEditProfileModel.fromJson(Map<String, dynamic> json) =>
      EmployerEditProfileModel(
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
  String? id;
  String? socialLoginType;
  String? fullName;
  String? phoneNumber;
  String? email;
  int? averageRating;
  dynamic facebookId;
  dynamic appleId;
  dynamic googleId;
  bool? isVerfied;
  String? role;
  String? password;
  String? profileImage;
  String? coverPhoto;
  String? stripeCustomerId;
  bool? isMobileVerify;
  bool? isOtpVerify;
  bool? isProfile;
  bool? reciveNotificaiton;
  String? fcmToken;
  bool? isSubscription;
  bool? isNotification;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Result({
    this.id,
    this.socialLoginType,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.averageRating,
    this.facebookId,
    this.appleId,
    this.googleId,
    this.isVerfied,
    this.role,
    this.password,
    this.profileImage,
    this.coverPhoto,
    this.stripeCustomerId,
    this.isMobileVerify,
    this.isOtpVerify,
    this.isProfile,
    this.reciveNotificaiton,
    this.fcmToken,
    this.isSubscription,
    this.isNotification,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    socialLoginType: json["socialLoginType"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    averageRating: json["averageRating"],
    facebookId: json["facebookId"],
    appleId: json["appleId"],
    googleId: json["googleId"],
    isVerfied: json["isVerfied"],
    role: json["role"],
    password: json["password"],
    profileImage: json["profileImage"],
    coverPhoto: json["coverPhoto"],
    stripeCustomerId: json["stripeCustomerId"],
    isMobileVerify: json["isMobileVerify"],
    isOtpVerify: json["isOtpVerify"],
    isProfile: json["isProfile"],
    reciveNotificaiton: json["reciveNotificaiton"],
    fcmToken: json["fcmToken"],
    isSubscription: json["isSubscription"],
    isNotification: json["isNotification"],
    status: json["status"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "socialLoginType": socialLoginType,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "email": email,
    "averageRating": averageRating,
    "facebookId": facebookId,
    "appleId": appleId,
    "googleId": googleId,
    "isVerfied": isVerfied,
    "role": role,
    "password": password,
    "profileImage": profileImage,
    "coverPhoto": coverPhoto,
    "stripeCustomerId": stripeCustomerId,
    "isMobileVerify": isMobileVerify,
    "isOtpVerify": isOtpVerify,
    "isProfile": isProfile,
    "reciveNotificaiton": reciveNotificaiton,
    "fcmToken": fcmToken,
    "isSubscription": isSubscription,
    "isNotification": isNotification,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
