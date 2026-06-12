// To parse this JSON data, do
//
//     final getJobEmployeerProfileDetailsModel = getJobEmployeerProfileDetailsModelFromJson(jsonString);

import 'dart:convert';

GetJobEmployeerProfileDetailsModel getJobEmployeerProfileDetailsModelFromJson(
  String str,
) => GetJobEmployeerProfileDetailsModel.fromJson(json.decode(str));

String getJobEmployeerProfileDetailsModelToJson(
  GetJobEmployeerProfileDetailsModel data,
) => json.encode(data.toJson());

class GetJobEmployeerProfileDetailsModel {
  bool? success;
  String? message;
  EmployerDetailsProfile? result;

  GetJobEmployeerProfileDetailsModel({this.success, this.message, this.result});

  factory GetJobEmployeerProfileDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) => GetJobEmployeerProfileDetailsModel(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null
        ? null
        : EmployerDetailsProfile.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class EmployerDetailsProfile {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? profileImage;
  String? introVideo;
  List<dynamic>? gallaryImages;
  int? isOnline;
  DateTime? lastActivateAt;
  dynamic jobSeekersProfile;
  EmployerProfile? employerProfile;
  String? phoneNumber;
  bool? isSubscription;

  EmployerDetailsProfile({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.profileImage,
    this.introVideo,
    this.gallaryImages,
    this.isOnline,
    this.lastActivateAt,
    this.jobSeekersProfile,
    this.employerProfile,
    this.phoneNumber,
    this.isSubscription,
  });

  factory EmployerDetailsProfile.fromJson(Map<String, dynamic> json) =>
      EmployerDetailsProfile(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        profileImage: json["profileImage"],
        introVideo: json["introVideo"],
        gallaryImages: json["gallaryImages"] == null
            ? []
            : List<dynamic>.from(json["gallaryImages"]!.map((x) => x)),
        jobSeekersProfile: json["job_seekers_profile"],
        employerProfile: json["employer_profile"] == null
            ? null
            : EmployerProfile.fromJson(json["employer_profile"]),
        phoneNumber: json["phoneNumber"],
        isOnline: json["isOnline"],
        lastActivateAt: json["lastActivateAt"] == null
            ? null
            : DateTime.parse(json['lastActivateAt']),
        isSubscription: json["isSubscription"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "role": role,
    "profileImage": profileImage,
    "introVideo": introVideo,
    "gallaryImages": gallaryImages == null
        ? []
        : List<dynamic>.from(gallaryImages!.map((x) => x)),
    "job_seekers_profile": jobSeekersProfile,
    "employer_profile": employerProfile?.toJson(),
    "phoneNumber": phoneNumber,
    "isOnline": isOnline,
    "lastActivateAt": lastActivateAt,
    "isSubscription": isSubscription,
  };
}

class EmployerProfile {
  String? companyAddress;
  String? companyCountry;
  String? companyEmail;
  DateTime? companyEstablishDate;
  String? companyName;
  String? companyPhoneNumber;
  String? companyWebsite;
  String? companyZipCode;

  EmployerProfile({
    this.companyAddress,
    this.companyCountry,
    this.companyEmail,
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
    "companyEstablishDate": companyEstablishDate?.toIso8601String(),
    "companyName": companyName,
    "companyPhoneNumber": companyPhoneNumber,
    "companyWebsite": companyWebsite,
    "companyZipCode": companyZipCode,
  };
}
