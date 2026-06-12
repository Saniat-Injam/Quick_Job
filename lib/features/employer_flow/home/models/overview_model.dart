
// import 'dart:convert';

// OverViewModel overViewModelFromJson(String str) =>
//     OverViewModel.fromJson(json.decode(str));

// String overViewModelToJson(OverViewModel data) => json.encode(data.toJson());

// class OverViewModel {
//   bool? success;
//   String? message;
//   Result? result;

//   OverViewModel({this.success, this.message, this.result});

//   factory OverViewModel.fromJson(Map<String, dynamic> json) => OverViewModel(
//     success: json["success"],
//     message: json["message"],
//     result: json["result"] == null ? null : Result.fromJson(json["result"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "result": result?.toJson(),
//   };
// }

// class Result {
//   int? totalJobPost;
//   int? totalJobApplied;
//   int? jobViews;
//   int? jobCandidate;

//   Result({
//     this.totalJobPost,
//     this.totalJobApplied,
//     this.jobViews,
//     this.jobCandidate,
//   });

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     totalJobPost: json["totalJobPost"],
//     totalJobApplied: json["totalJobApplied"],
//     jobViews: json["jobViews"],
//     jobCandidate: json["jobCandidate"],
//   );

//   Map<String, dynamic> toJson() => {
//     "totalJobPost": totalJobPost,
//     "totalJobApplied": totalJobApplied,
//     "jobViews": jobViews,
//     "jobCandidate": jobCandidate,
//   };
// }





import 'dart:convert';

OverViewModel overViewModelFromJson(String str) =>
    OverViewModel.fromJson(json.decode(str));

String overViewModelToJson(OverViewModel data) => json.encode(data.toJson());

class OverViewModel {
  bool? success;
  String? message;
  Result? result;

  OverViewModel({this.success, this.message, this.result});

  factory OverViewModel.fromJson(Map<String, dynamic> json) => OverViewModel(
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
  int? totalJobPost;
  int? totalJobApplied;
  int? jobViews;
  int? jobCandidate;

  Change? jobPostChange;
  Change? jobAppliedChange;
  Change? jobViewsChange;
  Change? jobCandidateChange;

  Result({
    this.totalJobPost,
    this.totalJobApplied,
    this.jobViews,
    this.jobCandidate,
    this.jobPostChange,
    this.jobAppliedChange,
    this.jobViewsChange,
    this.jobCandidateChange,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalJobPost: json["totalJobPost"],
    totalJobApplied: json["totalJobApplied"],
    jobViews: json["jobViews"],
    jobCandidate: json["jobCandidate"],
    jobPostChange: json["jobPostChange"] == null
        ? null
        : Change.fromJson(json["jobPostChange"]),
    jobAppliedChange: json["jobAppliedChange"] == null
        ? null
        : Change.fromJson(json["jobAppliedChange"]),
    jobViewsChange: json["jobViewsChange"] == null
        ? null
        : Change.fromJson(json["jobViewsChange"]),
    jobCandidateChange: json["jobCandidateChange"] == null
        ? null
        : Change.fromJson(json["jobCandidateChange"]),
  );

  Map<String, dynamic> toJson() => {
    "totalJobPost": totalJobPost,
    "totalJobApplied": totalJobApplied,
    "jobViews": jobViews,
    "jobCandidate": jobCandidate,
    "jobPostChange": jobPostChange?.toJson(),
    "jobAppliedChange": jobAppliedChange?.toJson(),
    "jobViewsChange": jobViewsChange?.toJson(),
    "jobCandidateChange": jobCandidateChange?.toJson(),
  };
}

class Change {
  int? percentage;
  String? trend;

  Change({this.percentage, this.trend});

  factory Change.fromJson(Map<String, dynamic> json) =>
      Change(percentage: json["percentage"], trend: json["trend"]);

  Map<String, dynamic> toJson() => {"percentage": percentage, "trend": trend};
}
