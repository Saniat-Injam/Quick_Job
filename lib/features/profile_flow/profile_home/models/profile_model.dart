// --- 1. Resume Model ---
class JobSeekerResumeModel {
  final String fileName;
  final String resumeUrl;
  final bool isSelected;

  JobSeekerResumeModel({
    required this.fileName,
    required this.resumeUrl,
    required this.isSelected,
  });

  factory JobSeekerResumeModel.fromJson(Map<String, dynamic> json) {
    return JobSeekerResumeModel(
      fileName: json['fileName'] as String? ?? 'N/A',
      resumeUrl: json['resumeUrl'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }
}

// --- 2. Job Seeker Profile Model ---
class JobSeekerProfileModel {
  final String occupation;
  final String address;
  final int age;
  final String desc;
  final String
  dob; // Keep as String for date, usually parsed to DateTime in use
  final String education;
  final String gender;
  final String languageNative;
  final String languageProfessional;
  final String jobExperience;
  final List<JobSeekerResumeModel> resumes;

  JobSeekerProfileModel({
    required this.occupation,
    required this.address,
    required this.age,
    required this.desc,
    required this.dob,
    required this.education,
    required this.gender,
    required this.languageNative,
    required this.languageProfessional,
    required this.jobExperience,
    required this.resumes,
  });

  factory JobSeekerProfileModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> resumeList = json['job_seekers_resume'] ?? [];
    return JobSeekerProfileModel(
      occupation: json['occupation'] as String? ?? 'N/A',
      address: json['address'] as String? ?? 'N/A',
      age: json['age'] as int? ?? 0,
      desc: json['desc'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      education: json['education'] as String? ?? 'N/A',
      gender: json['gender'] as String? ?? 'N/A',
      languageNative: json['languageNative'] as String? ?? 'N/A',
      languageProfessional: json['languageProfessional'] as String? ?? 'N/A',
      jobExperience:
          json['jobExperince'] as String? ??
          'N/A', // Note: JSON uses 'jobExperince'
      resumes: resumeList
          .map((i) => JobSeekerResumeModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

// --- 3. Employer Profile Model ---
class EmployerProfileModel {
  final String companyAddress;
  final String companyCountry;
  final String companyEmail;
  final String employRole;
  final String desc;
  final String companyEstablishDate; // Keep as String
  final String companyName;
  final String companyPhoneNumber;
  final String companyWebsite;
  final String companyZipCode;

  EmployerProfileModel({
    required this.companyAddress,
    required this.companyCountry,
    required this.companyEmail,
    required this.companyEstablishDate,
    required this.companyName,
    required this.companyPhoneNumber,
    required this.companyWebsite,
    required this.companyZipCode,
    required this.employRole,
    required this.desc,
  });

  factory EmployerProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployerProfileModel(
      companyAddress: json['companyAddress'] as String? ?? 'N/A',
      companyCountry: json['companyCountry'] as String? ?? 'N/A',
      companyEmail: json['companyEmail'] as String? ?? 'N/A',
      employRole: json['employRole'] as String? ?? 'HR',
      desc: json['desc'] as String? ?? 'N/A',
      companyEstablishDate: json['companyEstablishDate'] as String? ?? 'N/A',
      companyName: json['companyName'] as String? ?? 'N/A',
      companyPhoneNumber: json['companyPhoneNumber'] as String? ?? 'N/A',
      companyWebsite: json['companyWebsite'] as String? ?? 'N/A',
      companyZipCode: json['companyZipCode'] as String? ?? 'N/A',
    );
  }
}

// --- 4. Main User Profile Model (Combines all) ---
class UserProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String role; // NEW FIELD
  final String profileImage;
  final String phoneNumber;
  final bool isSubscription;

  // Nested Profiles (Optional, based on 'role')
  final JobSeekerProfileModel? jobSeekerProfile;
  final EmployerProfileModel? employerProfile;

  UserProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.phoneNumber,
    required this.isSubscription,
    this.jobSeekerProfile,
    this.employerProfile,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final jobSeekerJson = json['job_seekers_profile'] as Map<String, dynamic>?;
    final employerJson = json['employer_profile'] as Map<String, dynamic>?;

    return UserProfileModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? 'N/A',
      email: json['email'] as String? ?? 'N/A',
      role: json['role'] as String? ?? 'N/A', // New role field
      profileImage: json['profileImage'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? 'N/A',
      isSubscription: json['isSubscription'] as bool? ?? false,

      // Parse nested profiles only if the JSON object exists
      jobSeekerProfile: jobSeekerJson != null
          ? JobSeekerProfileModel.fromJson(jobSeekerJson)
          : null,
      employerProfile: employerJson != null
          ? EmployerProfileModel.fromJson(employerJson)
          : null,
    );
  }
}
