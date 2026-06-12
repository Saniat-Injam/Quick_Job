import 'package:get/get.dart';
import 'package:quick_job/features/auth/views/screens/create_password_screen.dart';
import 'package:quick_job/features/auth/views/screens/enterprise_screen.dart';
import 'package:quick_job/features/auth/views/screens/job_seeker_signup_screen.dart';
import 'package:quick_job/features/auth/views/screens/login_screen.dart';
import 'package:quick_job/features/auth/views/screens/reset_password_screen.dart';
import 'package:quick_job/features/auth/views/screens/sign_up_screen.dart';
import 'package:quick_job/features/auth/views/screens/otp_varification_screen.dart';
import 'package:quick_job/features/chat/views/screens/chat_screen..dart';
import 'package:quick_job/features/employer_flow/home/views/screens/employer_home_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/employer_applications_screen.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/sceens/job_seeker_home_screen.dart';
import 'package:quick_job/features/navbar/views/screens/navbar_screen.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/screens/job_details_screen.dart';
import 'package:quick_job/features/onboarding/views/screens/onboarding_screen.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/screens/resume_upload_screen.dart';
import 'package:quick_job/features/profile_flow/go_premium/views/screens/choose_plan_screen.dart';
import 'package:quick_job/features/splash_screen/views/screens/splash_screen.dart';

class AppRoute {
  static String init = "/";
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String bottomNavbar = "/bottomNavbar";
  static String homeScreen = "/homeScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String otpVerificationScreen = "/otpVerificationScreen";
  static String createPasswordScreen = "/createPasswordScreen";
  static String resumeUploadScreen = "/resumeUploadScreen";
  static String notificationScreen = "/notificationScreen";
  static String searchScreen2 = "/searchScreen2";
  static String jobDetailsScreen = "/jobDetailsScreen";
  static String applyJobScreen = "/applyJobScreen";
  static String chatScreen = "/chatScreen";
  static String enterpriseScreen = "/enterpriseScreen";
  static String employerHomeScreen = "/employerHomeScreen";
  static String employerApplicationScreen = "/employerApplicationScreen";
  static String jobSeekerSignUpScreen = "/jobSeekerSignUpScreen";
  static String individualChatScreen = "/individualChatScreen";
  static String choosePlanScreen = "/choose_plan_screen";

  static List<GetPage> routes = [
    GetPage(name: init, page: () => SplashScreen()),

    GetPage(
      name: loginScreen,
      page: () {
        String role = 'job_seeker';
        if (Get.arguments != null && Get.arguments is Map) {
          role = Get.arguments['role'] is String
              ? Get.arguments['role'] as String
              : 'job_seeker';
        }

        return LoginScreen(role: role);
      },
    ),

    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: createPasswordScreen, page: () => CreatePasswordScreen()),
    GetPage(name: bottomNavbar, page: () => NavBarScreen()),
    GetPage(
      name: AppRoute.homeScreen,
      page: () {
        final arguments = Get.arguments;
        final userRole = arguments != null ? arguments['role'] : 'guest';
        return HomeScreen(userRole: userRole);
      },
    ),

    // GetPage(
    //   name: bottomNavbar,
    //   page: () {
    //     // Check if Get.arguments is a Map and extract the role
    //     var role = 'job_seeker';  // Default value
    //
    //     if (Get.arguments != null) {
    //       if (Get.arguments is Map) {
    //         // If arguments is a Map, extract the 'role'
    //         role = Get.arguments['role'] ?? 'job_seeker';
    //       } else if (Get.arguments is String) {
    //         // If arguments is a String, use it as the role
    //         role = Get.arguments as String;
    //       }
    //     }
    //
    //     return NavBarScreen(role: role);  // Pass the correct role
    //   },
    // ),
    GetPage(name: otpVerificationScreen, page: () => OtpVerificationScreen()),
    GetPage(
      name: resumeUploadScreen,
      page: () {
        final arguments = Get.arguments;
        final userRole = arguments != null ? arguments['role'] : 'guest';
        return ResumeUploadScreen(userRole: userRole);
      },
    ),
    GetPage(name: jobDetailsScreen, page: () => JobDetailsScreen()),
    GetPage(name: chatScreen, page: () => ChatScreen()),
    GetPage(name: enterpriseScreen, page: () => EnterpriseScreen()),
    GetPage(
      name: AppRoute.employerHomeScreen,
      page: () {
        final arguments = Get.arguments;
        final userRole = arguments != null ? arguments['role'] : 'guest';
        return EmployerHomeScreen(userRole: userRole);
      },
    ),
    GetPage(
      name: employerApplicationScreen,
      page: () => EmployerApplicationsScreen(),
    ),
    GetPage(name: jobSeekerSignUpScreen, page: () => JobSeekerSignupScreen()),
    GetPage(name: choosePlanScreen, page: () => ChoosePlanScreen()),
  ];
}
