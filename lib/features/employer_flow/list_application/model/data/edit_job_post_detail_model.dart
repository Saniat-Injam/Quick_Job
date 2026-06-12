class JobPostResponse {
  final bool success;
  final String message;
  final Result result;

  JobPostResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory JobPostResponse.fromJson(Map<String, dynamic> json) {
    return JobPostResponse(
      success: json['success'],
      message: json['message'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final Meta meta;
  final List<JobPost> data;

  Result({
    required this.meta,
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      meta: Meta.fromJson(json['meta']),
      data: List<JobPost>.from(
        json['data'].map((jobPost) => JobPost.fromJson(jobPost)),
      ),
    );
  }
}

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

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
  final String jobPostStatus;
  final String jobCategory;
  final String position;
  final int salary;
  final String jobType;
  final List<String> requirements;
  final String location;
  final EmployerProfile employerProfile;

  JobPost({
    required this.jobPostStatus,
    required this.jobCategory,
    required this.position,
    required this.salary,
    required this.jobType,
    required this.requirements,
    required this.location,
    required this.employerProfile,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      jobPostStatus: json['jobPostStatus'],
      jobCategory: json['JobCategory'],
      position: json['position'],
      salary: json['salary'],
      jobType: json['jobType'],
      requirements: List<String>.from(json['requirements']),
      location: json['location'],
      employerProfile: EmployerProfile.fromJson(json['employeer_profile']),
    );
  }
}

class EmployerProfile {
  final String companyName;

  EmployerProfile({
    required this.companyName,
  });

  factory EmployerProfile.fromJson(Map<String, dynamic> json) {
    return EmployerProfile(
      companyName: json['companyName'],
    );
  }
}
