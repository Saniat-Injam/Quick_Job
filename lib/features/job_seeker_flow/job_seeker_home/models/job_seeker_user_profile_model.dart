// To parse this JSON data, do
//
//     final getJobSeekerUserProfileModel = getJobSeekerUserProfileModelFromJson(jsonString);

import 'dart:convert';

GetJobSeekerUserProfileModel getJobSeekerUserProfileModelFromJson(String str) =>
    GetJobSeekerUserProfileModel.fromJson(json.decode(str));

String getJobSeekerUserProfileModelToJson(GetJobSeekerUserProfileModel data) =>
    json.encode(data.toJson());

class GetJobSeekerUserProfileModel {
  bool? success;
  String? message;
  JobSeekerProfile? result;

  GetJobSeekerUserProfileModel({this.success, this.message, this.result});

  factory GetJobSeekerUserProfileModel.fromJson(Map<String, dynamic> json) =>
      GetJobSeekerUserProfileModel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? null
            : JobSeekerProfile.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class JobSeekerProfile {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? profileImage;
  String? introVideo;
  List? gallaryImages;
  JobSeekersProfile? jobSeekersProfile;
  String? employerProfile;
  String? phoneNumber;
  bool? isSubscription;

  JobSeekerProfile({
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

  factory JobSeekerProfile.fromJson(Map<String, dynamic> json) =>
      JobSeekerProfile(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        profileImage: json["profileImage"],
        introVideo: json["introVideo"],
        gallaryImages: json["gallaryImages"] ?? [],
        jobSeekersProfile: json["job_seekers_profile"] == null
            ? null
            : JobSeekersProfile.fromJson(json["job_seekers_profile"]),
        employerProfile: json["employer_profile"],
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
    "job_seekers_profile": jobSeekersProfile?.toJson(),
    "employer_profile": employerProfile,
    "phoneNumber": phoneNumber,
    "isSubscription": isSubscription,
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

  factory JobSeekersProfile.fromJson(Map<String, dynamic> json) {
    return JobSeekersProfile(
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
  }

  Map<String, dynamic> toJson() {
    return {
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
