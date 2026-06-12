// To parse this JSON data, do
//
//     final recentlyAppliedCandidatesModel = recentlyAppliedCandidatesModelFromJson(jsonString);

import 'dart:convert';

RecentlyAppliedCandidatesModel recentlyAppliedCandidatesModelFromJson(
  String str,
) => RecentlyAppliedCandidatesModel.fromJson(json.decode(str));

String recentlyAppliedCandidatesModelToJson(
  RecentlyAppliedCandidatesModel data,
) => json.encode(data.toJson());

class RecentlyAppliedCandidatesModel {
  bool? success;
  String? message;
  Result? result;

  RecentlyAppliedCandidatesModel({this.success, this.message, this.result});

  factory RecentlyAppliedCandidatesModel.fromJson(Map<String, dynamic> json) =>
      RecentlyAppliedCandidatesModel(
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
  List<ApliedData>? data;

  Result({this.meta, this.data});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null
        ? []
        : List<ApliedData>.from(
            json["data"]!.map((x) => ApliedData.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ApliedData {
  String? id;
  String? status;
  dynamic interviewDate;
  dynamic interViewTime;
  dynamic message;
  JobSeekersProfile? jobSeekersProfile;
  JobPost? jobPost;

  ApliedData({
    this.id,
    this.status,
    this.interviewDate,
    this.interViewTime,
    this.message,
    this.jobSeekersProfile,
    this.jobPost,
  });

  factory ApliedData.fromJson(Map<String, dynamic> json) => ApliedData(
    id: json["id"],
    status: json["status"],
    interviewDate: json["InterviewDate"],
    interViewTime: json["InterViewTime"],
    message: json["message"],
    jobSeekersProfile: json["job_seekers_profile"] == null
        ? null
        : JobSeekersProfile.fromJson(json["job_seekers_profile"]),
    jobPost: json["jobPost"] == null ? null : JobPost.fromJson(json["jobPost"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "InterviewDate": interviewDate,
    "InterViewTime": interViewTime,
    "message": message,
    "job_seekers_profile": jobSeekersProfile?.toJson(),
    "jobPost": jobPost?.toJson(),
  };
}

class JobPost {
  String? id;
  String? position;
  int? salary;
  String? location;
  String? jobPostStatus;
  String? jobType;
  String? jobCategory;
  List<String>? requirements;
  EmployeerProfile? employeerProfile;

  JobPost({
    this.id,
    this.position,
    this.salary,
    this.location,
    this.jobPostStatus,
    this.jobType,
    this.jobCategory,
    this.requirements,
    this.employeerProfile,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) => JobPost(
    id: json["id"],
    position: json["position"],
    salary: json["salary"],
    location: json["location"],
    jobPostStatus: json["jobPostStatus"],
    jobType: json["jobType"],
    jobCategory: json["JobCategory"],
    requirements: json["requirements"] == null
        ? []
        : List<String>.from(json["requirements"]!.map((x) => x)),
    employeerProfile: json["employeer_profile"] == null
        ? null
        : EmployeerProfile.fromJson(json["employeer_profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
    "salary": salary,
    "location": location,
    "jobPostStatus": jobPostStatus,
    "jobType": jobType,
    "JobCategory": jobCategory,
    "requirements": requirements == null
        ? []
        : List<dynamic>.from(requirements!.map((x) => x)),
    "employeer_profile": employeerProfile?.toJson(),
  };
}

class EmployeerProfile {
  String? id;
  String? companyName;
  EmployeerProfileUser? user;

  EmployeerProfile({this.id, this.companyName, this.user});

  factory EmployeerProfile.fromJson(Map<String, dynamic> json) =>
      EmployeerProfile(
        id: json["id"],
        companyName: json["companyName"],
        user: json["user"] == null
            ? null
            : EmployeerProfileUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "user": user?.toJson(),
  };
}

class EmployeerProfileUser {
  String? id;
  String? fullName;
  String? profileImage;

  EmployeerProfileUser({this.id, this.fullName, this.profileImage});

  factory EmployeerProfileUser.fromJson(Map<String, dynamic> json) =>
      EmployeerProfileUser(
        id: json["id"],
        fullName: json["fullName"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profileImage": profileImage,
  };
}

class JobSeekersProfile {
  String? occupation;
  String? userId;
  JobSeekersProfileUser? user;
  List<ResoumeList>? resumeList;

  JobSeekersProfile({this.occupation, this.user, this.userId, this.resumeList});

  factory JobSeekersProfile.fromJson(Map<String, dynamic> json) {
    return JobSeekersProfile(
      occupation: json["occupation"],
      userId: json["userId"],
      user: json["user"] == null
          ? null
          : JobSeekersProfileUser.fromJson(json["user"]),
      resumeList: json["job_seekers_resume"] == null
          ? []
          : List<ResoumeList>.from(
              json["job_seekers_resume"].map((x) => ResoumeList.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "occupation": occupation,
    "userId": userId,
    "user": user?.toJson(),
    "job_seekers_resume": resumeList?.map((x) => x.toJson()).toList() ?? [],
  };
}

class ResoumeList {
  final String? fileName;
  final String? resumeUrl;

  ResoumeList({this.fileName, this.resumeUrl});

  factory ResoumeList.fromJson(Map<String, dynamic> json) {
    return ResoumeList(
      fileName: json['fileName'],
      resumeUrl: json['resumeUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'resumeUrl': resumeUrl};
  }
}

class JobSeekersProfileUser {
  String? fullName;
  String? phoneNumber;
  String? profileImage;
  int? isOnline;
  DateTime? lastActivateAt;
  List? likeReceive;

  JobSeekersProfileUser({
    this.fullName,
    this.phoneNumber,
    this.profileImage,
    this.isOnline,
    this.lastActivateAt,
    this.likeReceive,
  });

  factory JobSeekersProfileUser.fromJson(Map<String, dynamic> json) =>
      JobSeekersProfileUser(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"],
        isOnline: json["isOnline"],
        lastActivateAt: json["lastActivateAt"] == null
            ? null
            : DateTime.parse(json['lastActivateAt']),
        likeReceive: json['likeReceive'] ?? [],
      );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "profileImage": profileImage,
    "isOnline": isOnline,
    "lastActivateAt": lastActivateAt,
    "likeReceive": likeReceive,
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
