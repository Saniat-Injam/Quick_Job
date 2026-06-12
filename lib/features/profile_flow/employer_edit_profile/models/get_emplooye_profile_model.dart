// To parse this JSON data, do
//
//     final getEmployeeUserProfileModel = getEmployeeUserProfileModelFromJson(jsonString);

import 'dart:convert';

GetEmployeeUserProfileModel getEmployeeUserProfileModelFromJson(String str) =>
    GetEmployeeUserProfileModel.fromJson(json.decode(str));

String getEmployeeUserProfileModelToJson(GetEmployeeUserProfileModel data) =>
    json.encode(data.toJson());

class GetEmployeeUserProfileModel {
  bool? success;
  String? message;
  EmplooyeProfileData? result;

  GetEmployeeUserProfileModel({this.success, this.message, this.result});

  factory GetEmployeeUserProfileModel.fromJson(Map<String, dynamic> json) =>
      GetEmployeeUserProfileModel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? null
            : EmplooyeProfileData.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class EmplooyeProfileData {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? profileImage;
  String? introVideo;
  List? gallaryImages;
  dynamic jobSeekersProfile;
  EmployerProfile? employerProfile;
  String? phoneNumber;
  bool? isSubscription;

  EmplooyeProfileData({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.profileImage,
    this.introVideo,
    this.gallaryImages,
    this.jobSeekersProfile,
    this.employerProfile,
    this.phoneNumber,
    this.isSubscription,
  });

  factory EmplooyeProfileData.fromJson(Map<String, dynamic> json) =>
      EmplooyeProfileData(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        profileImage: json["profileImage"],
        introVideo: json["introVideo"],
        gallaryImages: json["gallaryImages"] ?? [],
        jobSeekersProfile: json["job_seekers_profile"],
        employerProfile: json["employer_profile"] == null
            ? null
            : EmployerProfile.fromJson(json["employer_profile"]),
        phoneNumber: json["phoneNumber"],
        isSubscription: json["isSubscription"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "role": role,
    "profileImage": profileImage,
    "introVideo": introVideo,
    "gallaryImages": gallaryImages,
    "job_seekers_profile": jobSeekersProfile,
    "employer_profile": employerProfile?.toJson(),
    "phoneNumber": phoneNumber,
    "isSubscription": isSubscription,
  };
}

class EmployerProfile {
  String? companyAddress;
  String? companyCountry;
  String? companyEmail;
  String? employRole;
  String? desc;
  DateTime? companyEstablishDate;
  String? companyName;
  String? companyPhoneNumber;
  String? companyWebsite;
  String? companyZipCode;

  EmployerProfile({
    this.companyAddress,
    this.companyCountry,
    this.companyEmail,
    this.employRole,
    this.desc,
    this.companyEstablishDate,
    this.companyName,
    this.companyPhoneNumber,
    this.companyWebsite,
    this.companyZipCode,
  });

  factory EmployerProfile.fromJson(Map<String, dynamic> json) =>
      EmployerProfile(
        companyAddress: json["companyAddress"],
        companyCountry: json["companyCountry"],
        companyEmail: json["companyEmail"],
        employRole: json["employRole"],
        desc: json["desc"],
        companyEstablishDate: json["companyEstablishDate"] == null
            ? null
            : DateTime.parse(json["companyEstablishDate"]),
        companyName: json["companyName"],
        companyPhoneNumber: json["companyPhoneNumber"],
        companyWebsite: json["companyWebsite"],
        companyZipCode: json["companyZipCode"],
      );

  Map<String, dynamic> toJson() => {
    "companyAddress": companyAddress,
    "companyCountry": companyCountry,
    "companyEmail": companyEmail,
    "employRole": employRole,
    "desc": desc,
    "companyEstablishDate": companyEstablishDate?.toIso8601String(),
    "companyName": companyName,
    "companyPhoneNumber": companyPhoneNumber,
    "companyWebsite": companyWebsite,
    "companyZipCode": companyZipCode,
  };
}
