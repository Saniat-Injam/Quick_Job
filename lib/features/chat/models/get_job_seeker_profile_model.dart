// To parse this JSON data, do
//
//     final getJobSeekerProfileDetailsModel = getJobSeekerProfileDetailsModelFromJson(jsonString);

import 'dart:convert';

GetJobSeekerProfileDetailsModel getJobSeekerProfileDetailsModelFromJson(
  String str,
) => GetJobSeekerProfileDetailsModel.fromJson(json.decode(str));

String getJobSeekerProfileDetailsModelToJson(
  GetJobSeekerProfileDetailsModel data,
) => json.encode(data.toJson());

class GetJobSeekerProfileDetailsModel {
  bool? success;
  String? message;
  JobSeekerDetailsProfile? result;

  GetJobSeekerProfileDetailsModel({this.success, this.message, this.result});

  factory GetJobSeekerProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetJobSeekerProfileDetailsModel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? null
            : JobSeekerDetailsProfile.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class JobSeekerDetailsProfile {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? profileImage;
  String? introVideo;
  List<String>? gallaryImages;
  JobSeekersProfile? jobSeekersProfile;
  int? isOnline;
  DateTime? lastActivateAt;
  dynamic employerProfile;
  String? phoneNumber;
  bool? isSubscription;

  JobSeekerDetailsProfile({
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
    this.lastActivateAt,
    this.isOnline,
    this.isSubscription,
  });

  factory JobSeekerDetailsProfile.fromJson(Map<String, dynamic> json) =>
      JobSeekerDetailsProfile(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        profileImage: json["profileImage"],
        introVideo: json["introVideo"],
        gallaryImages: json["gallaryImages"] == null
            ? []
            : List<String>.from(json["gallaryImages"]!.map((x) => x)),
        jobSeekersProfile: json["job_seekers_profile"] == null
            ? null
            : JobSeekersProfile.fromJson(json["job_seekers_profile"]),
        employerProfile: json["employer_profile"],
        phoneNumber: json["phoneNumber"],
        lastActivateAt: json["lastActivateAt"] == null
            ? null
            : DateTime.parse(json['lastActivateAt']),
        isOnline: json["isOnline"],
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
    "job_seekers_profile": jobSeekersProfile?.toJson(),
    "employer_profile": employerProfile,
    "phoneNumber": phoneNumber,
    "isSubscription": isSubscription,
    "isOnline": isOnline,
    "lastActivateAt": lastActivateAt,
  };
}

class JobSeekersProfile {
  String? occupation;
  String? address;
  int? age;
  String? desc;
  DateTime? dob;
  String? education;
  String? gender;
  String? languageNative;
  String? languageProfessional;
  String? jobExperince;
  List<JobSeekersResume>? jobSeekersResume;

  JobSeekersProfile({
    this.occupation,
    this.address,
    this.age,
    this.desc,
    this.dob,
    this.education,
    this.gender,
    this.languageNative,
    this.languageProfessional,
    this.jobExperince,
    this.jobSeekersResume,
  });

  factory JobSeekersProfile.fromJson(Map<String, dynamic> json) =>
      JobSeekersProfile(
        occupation: json["occupation"],
        address: json["address"],
        age: json["age"],
        desc: json["desc"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        education: json["education"],
        gender: json["gender"],
        languageNative: json["languageNative"],
        languageProfessional: json["languageProfessional"],
        jobExperince: json["jobExperince"],
        jobSeekersResume: json["job_seekers_resume"] == null
            ? []
            : List<JobSeekersResume>.from(
                json["job_seekers_resume"].map(
                  (x) => JobSeekersResume.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
    "occupation": occupation,
    "address": address,
    "age": age,
    "desc": desc,
    "dob": dob?.toIso8601String(),
    "education": education,
    "gender": gender,
    "languageNative": languageNative,
    "languageProfessional": languageProfessional,
    "jobExperince": jobExperince,
    "job_seekers_resume": jobSeekersResume == null
        ? []
        : jobSeekersResume!.map((x) => x.toJson()).toList(),
  };
}

class JobSeekersResume {
  String? fileName;
  String? resumeUrl;
  bool? isSelected;

  JobSeekersResume({this.fileName, this.resumeUrl, this.isSelected});

  factory JobSeekersResume.fromJson(Map<String, dynamic> json) {
    return JobSeekersResume(
      fileName: json['fileName'],
      resumeUrl: json['resumeUrl'],
      isSelected: json['isSelected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'resumeUrl': resumeUrl,
      'isSelected': isSelected,
    };
  }
}
