class JobPostResponse {
  bool success;
  String message;
  Result result;

  JobPostResponse({required this.success, required this.message, required this.result});

  factory JobPostResponse.fromJson(Map<String, dynamic> json) {
    return JobPostResponse(
      success: json['success'],
      message: json['message'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  Meta meta;
  List<JobPost> data;

  Result({required this.meta, required this.data});

  factory Result.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<JobPost> dataList = list.map((i) => JobPost.fromJson(i)).toList();

    return Result(
      meta: Meta.fromJson(json['meta']),
      data: dataList,
    );
  }
}

class Meta {
  int total;
  int page;
  int limit;
  int totalPages;

  Meta({required this.total, required this.page, required this.limit, required this.totalPages});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}

class JobPost {
  String jobPostStatus;
  String jobCategory;
  String position;
  int salary;
  String jobType;
  List<String> requirements;
  EmployerProfile employeerProfile;

  JobPost({
    required this.jobPostStatus,
    required this.jobCategory,
    required this.position,
    required this.salary,
    required this.jobType,
    required this.requirements,
    required this.employeerProfile,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    var list = json['requirements'] as List;
    List<String> requirementsList = list.map((i) => i.toString()).toList();

    return JobPost(
      jobPostStatus: json['jobPostStatus'],
      jobCategory: json['JobCategory'],
      position: json['position'],
      salary: json['salary'],
      jobType: json['jobType'],
      requirements: requirementsList,
      employeerProfile: EmployerProfile.fromJson(json['employeer_profile']),
    );
  }
}

class EmployerProfile {
  String companyName;

  EmployerProfile({required this.companyName});

  factory EmployerProfile.fromJson(Map<String, dynamic> json) {
    return EmployerProfile(companyName: json['companyName']);
  }
}
