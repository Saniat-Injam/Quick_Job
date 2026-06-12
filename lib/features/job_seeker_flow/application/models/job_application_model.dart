// Define the inner-most User model to get the profile image (logo)
class UserModel {
  final String profileImage;

  UserModel({required this.profileImage});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(profileImage: json['profileImage'] ?? '');
  }
}

// Define the EmployerProfile model
class EmployerProfileModel {
  final String companyName;
  final UserModel user;
  

  EmployerProfileModel({required this.companyName, required this.user});

  factory EmployerProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployerProfileModel(
      companyName: json['companyName'] ?? 'Unknown Company',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}

// Define the JobPost model
class JobPostModel {
  final String id;
  final String position;
  final int salary;
  final String location;
  final String jobType;
  
  final EmployerProfileModel employerProfile;
  

  JobPostModel({
    required this.id,
    required this.position,
    required this.salary,
    required this.location,
    required this.jobType,
    required this.employerProfile,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) {
    return JobPostModel(
      id: json['id'] ?? '',
      position: json['position'] ?? 'N/A',
      salary: (json['salary'] as num?)?.toInt() ?? 0,
      location: json['location'] ?? 'N/A',
      jobType: json['jobType'] ?? 'N/A',
      employerProfile: EmployerProfileModel.fromJson(
        json['employeer_profile'] ?? {},
      ),
    );
  }
}

// Define the main JobApplication model with the missing interview fields
class JobApplicationModel {
  final String id;
  final String status;
  // --- ADDED MISSING FIELDS ---
  final DateTime? InterviewDate;
  final String? InterViewTime;
  final String? message;
  // -----------------------------
  final JobPostModel jobPost;

  JobApplicationModel({
    required this.id,
    required this.status,
    this.InterviewDate,
    this.InterViewTime,
    this.message,
    required this.jobPost,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      id: json['id'] ?? '',
      status: json['status'] ?? 'PENDING',
      // Safely access optional fields
      InterviewDate: json["InterviewDate"] == null
          ? null
          : DateTime.parse(json["InterviewDate"]),

        
      InterViewTime: json['InterViewTime'] ?? 'N/A',
      message: json['message'],
      jobPost: JobPostModel.fromJson(json['jobPost'] ?? {}),
    );
  }

  // Getter used by JobCard for the logo URL
  String get logoUrl => jobPost.employerProfile.user.profileImage;
}
