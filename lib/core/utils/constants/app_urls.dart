class AppUrls {
  AppUrls._();
  static const String webSocket = 'wss://api.jobschatting.com';

  static const String _baseUrl = 'https://api.jobschatting.com/api/v1';
  // static const String local = 'http://206.162.244.142:5043/api/v1';
  //  static const String _baseUrl = 'http://10.0.30.17:5043/api/v1';

  static const String signUp = '$_baseUrl/user/create';
  static const String getMe = '$_baseUrl/user/get-profile';
  static const String logIn = '$_baseUrl/auth/login';

  static const String verifyOtp = '$_baseUrl/auth/verfiy-otp';
  static const String resendOtp = '$_baseUrl/auth/resend-otp';
  static const String forgotPassword =
      '$_baseUrl/auth/forgetpassword-otp-to-gmail';

  // Social Login
  static const String googleLogin = '$_baseUrl/auth/social-login';
  static const String getProfile = '$_baseUrl/user/get-profile';
  static const String jobSeekerSignUp = '$_baseUrl/user/create';
  static const String uploadResume = '$_baseUrl/user/upload-resume';

  static const String employerJobPost =
      '$_baseUrl/job/get-employeer-job-post?status=ACTIVE';
  static const String resetPassword = '$_baseUrl/auth/change-password';
  static const String getAllJobs = '$_baseUrl/job/get-all-jobs';
  static const String createJobPost = '$_baseUrl/job/create-job-post';

  // ------Added by Nifat
  static const String getAllAppliedJobs =
      '$_baseUrl/job/employeer-job-apply-list';

  // also needed in employer_home_screen
  static const String getEmployerJobPost =
      '$_baseUrl/job/get-employeer-job-post';
  static const String updateProfile = '$_baseUrl/user/update-profile';
  static String jobApply({required String jobPostId}) {
    return '$_baseUrl/job/apply-job/$jobPostId';
  }

  static String updateJobApplyStatus({required String jobApplyId}) {
    return '$_baseUrl/job/update-job-apply-status/$jobApplyId';
  }

  static String deleteResume({required String resumeId}) =>
      '$_baseUrl/user/delete-resume/$resumeId';
  static String updateJobPost({required String jobPostId}) =>
      '$_baseUrl/job/update-job-post/$jobPostId';
  static String getSingleJobPost({required String jobPostId}) =>
      '$_baseUrl/job/get-single-job-post/$jobPostId';

  static String getConversationList = '$_baseUrl/chats/conversation-list';
  static String getMessageListForUser({required String conversationId}) {
    return '$_baseUrl/chats/get-conversation-messages/$conversationId';
  }

  // static String getEmployerAppliedJobList =
  //     '$_baseUrl/job/employeer-job-apply-list?page=1&limit=2';
  // static String getEmployerAppliedJobList =
  //     '$_baseUrl/job/employeer-job-apply-list';

  static String jobSeekerProfileUpdate = '$_baseUrl/user/update-profile';
  static String employerProfileUpdate = '$_baseUrl/user/update-profile';

  // Employer Home Screen
  static String employerDashBoardData =
      '$_baseUrl/user/employeer-dashboard-data';
  static String recentlyAppliedCandidates =
      '$_baseUrl/job/employeer-job-apply-list';
  static String getUserNotification = '$_baseUrl/notification';
  static String updateJObStatus = '$_baseUrl/job/update-job-apply-status/';
  static String getAllSubscriptionPlan =
      '$_baseUrl/subscription/get-subscription';
  static String buySubscriptionPlan =
      '$_baseUrl/subscription/purchase-subscription';
  static String deleteAJobPost({required String jobPostId}) =>
      '$_baseUrl/job/job-post/$jobPostId';

  // static String getJobSekerAplyedJob({required Map<String, String> status}) =>
  //     '$_baseUrl/job/get-all-applied-jobs?$status';

  static String getJobSekerAplyedJob({required Map<String, String> status}) {
    return Uri.parse(
      "$_baseUrl/job/get-all-applied-jobs",
    ).replace(queryParameters: status).toString();
  }

  static const String sendCallNotification =
      "$_baseUrl/notification/single-user-notificaiton";
  static const String resetNewPassword = "$_baseUrl/auth/reset-password";
  static const String uploadImage = "$_baseUrl/chats/chat-image-upload";
  static String getOtherUserProfile({required String userId}) =>
      "$_baseUrl/user/get-other-user-profile/$userId";

  // static String updateGalleryImg = '$_baseUrl/user/upload-gallary';
  static String addNewGalleryImg = '$_baseUrl/user/upload-gallary';
  static String deleteImg(int index) =>
      '$_baseUrl/user/upload-gallary?index=$index&indicator=delete';
  static String updateGalleryImg(int index) =>
      '$_baseUrl/user/upload-gallary?index=$index&indicator=push';
  static String likeOrUnlike({required String receiverUserId}) =>
      '$_baseUrl/like/$receiverUserId';

  static const String getLikedUserList = "$_baseUrl/like/all-liked-list";
  static const String getProfileVisitorList =
      "$_baseUrl/user/profile-viewer-list";
}
