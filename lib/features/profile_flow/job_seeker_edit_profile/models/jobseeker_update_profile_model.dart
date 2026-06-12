

class JobSeekersProfileModel {
  bool? success;
  String? message;
  Result? result;

  JobSeekersProfileModel({this.success, this.message, this.result});

  JobSeekersProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? id;
  String? socialLoginType;
  String? fullName;
  String? phoneNumber;
  String? email;
  int? averageRating;
  Null facebookId;
  Null appleId;
  Null googleId;
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
  String? createdAt;
  String? updatedAt;

  Result(
      {this.id,
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
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialLoginType = json['socialLoginType'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    averageRating = json['averageRating'];
    facebookId = json['facebookId'];
    appleId = json['appleId'];
    googleId = json['googleId'];
    isVerfied = json['isVerfied'];
    role = json['role'];
    password = json['password'];
    profileImage = json['profileImage'];
    coverPhoto = json['coverPhoto'];
    stripeCustomerId = json['stripeCustomerId'];
    isMobileVerify = json['isMobileVerify'];
    isOtpVerify = json['isOtpVerify'];
    isProfile = json['isProfile'];
    reciveNotificaiton = json['reciveNotificaiton'];
    fcmToken = json['fcmToken'];
    isSubscription = json['isSubscription'];
    isNotification = json['isNotification'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['socialLoginType'] = socialLoginType;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['averageRating'] = averageRating;
    data['facebookId'] = facebookId;
    data['appleId'] = appleId;
    data['googleId'] = googleId;
    data['isVerfied'] = isVerfied;
    data['role'] = role;
    data['password'] = password;
    data['profileImage'] = profileImage;
    data['coverPhoto'] = coverPhoto;
    data['stripeCustomerId'] = stripeCustomerId;
    data['isMobileVerify'] = isMobileVerify;
    data['isOtpVerify'] = isOtpVerify;
    data['isProfile'] = isProfile;
    data['reciveNotificaiton'] = reciveNotificaiton;
    data['fcmToken'] = fcmToken;
    data['isSubscription'] = isSubscription;
    data['isNotification'] = isNotification;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
