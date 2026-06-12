class NearbyJobModel {
  final String id;
  final String profileImage;
  final String title;
  final String company;
  final String salary;
  final String location;
  final String postedTime;
  final String jobType;
  final String jobCategory;
  final List<String> requirements;
  final String jobPostStatus;
  final String userId;
  final String userName;
  final int isOnline;
  final DateTime lastOnlineAt;
  final bool isLiked;

  NearbyJobModel({
    required this.isLiked,
    required this.id,
    required this.profileImage,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
    required this.postedTime,
    required this.jobType,
    required this.jobCategory,
    required this.requirements,
    required this.jobPostStatus,
    required this.userId,
    required this.userName,
    required this.isOnline,
    required this.lastOnlineAt,
  });
}
