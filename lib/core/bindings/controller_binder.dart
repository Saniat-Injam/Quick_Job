import 'package:get/get.dart';
import 'package:quick_job/features/auth/controllers/job_seeker_controller.dart';
import 'package:quick_job/features/auth/controllers/sign_up_controller.dart';
import 'package:quick_job/features/auth/controllers/varification_controller.dart';
import 'package:quick_job/features/auth/models/varification_model.dart';
import 'package:quick_job/features/chat/controllers/chat_controller.dart';
import 'package:quick_job/features/chat/controllers/individual_chat_controller.dart';
import 'package:quick_job/features/chat/controllers/view_user_detail_controller.dart';
import 'package:quick_job/features/chat/controllers/web_socket_controller.dart';
import 'package:quick_job/features/employer_flow/home/controllers/employer_home_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/aplication_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/aplication_detail_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/create_post_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/create_requedment_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/edit_job_post_detail_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/employer_controller.dart';
import 'package:quick_job/features/chat/controllers/audio_call_controller.dart';
import 'package:quick_job/features/chat/controllers/upload_controller.dart';
import 'package:quick_job/features/chat/controllers/video_call_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/see_candidate_controller.dart';
import 'package:quick_job/features/job_seeker_flow/application/controller/job_application_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/apply_job_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/job_details_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/resume_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/controllers/home_controller.dart';
import 'package:quick_job/features/job_seeker_flow/search/controllers/search_controller.dart';
import 'package:quick_job/features/job_seeker_flow/search/controllers/search_result_job_controller.dart';
import 'package:quick_job/features/navbar/controllers/navbar_controller.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller_for_client.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/controller/job_seeker_update_profile_controller.dart';
import 'package:quick_job/features/profile_flow/go_premium/controllers/choose_plan_controller.dart';
import 'package:quick_job/features/profile_flow/go_premium/controllers/premium_controller.dart';
import 'package:quick_job/features/profile_flow/help/controllers/privacy_policy_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/favorite_list_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/image_preview_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/profile_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/show_profile_visitor_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/upload_gallary_photos_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    // Get.lazyPut(
    //       () {
    //     final email = Get.arguments?['email'] as String? ?? '';
    //     return VerificationController(VerificationModel(email: email));
    //   },
    // );
    Get.lazyPut(() {
      String email = '';

      // Safely extract email from arguments
      final args = Get.arguments;
      if (args is Map && args.containsKey('email')) {
        email = args['email'] as String;
      } else if (args is String) {
        // Handle case where email is passed directly as string
        email = args;
      }

      return VerificationController(VerificationModel(email: email));
    }, fenix: true);

    // Get.lazyPut(() => VerificationController(),fenix: true);
    // Get.lazyPut(() => GoogleAuthService(), fenix: true);
    //Get.lazyPut(() => SocialController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    //Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => JobDetailsController(), fenix: true);
    Get.lazyPut(() => ApplyJobController(), fenix: true);
    Get.lazyPut(() => JobApplicationController(), fenix: true);
    Get.lazyPut(() => SearchScreenController(), fenix: true);
    Get.lazyPut(() => SearchResultJobController(), fenix: true);
    Get.lazyPut(() => EmployerController(), fenix: true);
    Get.lazyPut(() => CreateJobPostController(), fenix: true);
    Get.lazyPut(() => CreateRequedmentController(), fenix: true);
    Get.lazyPut(() => UploadController(), fenix: true);
    Get.lazyPut(() => ProfileAlertController(), fenix: true);
    Get.lazyPut(() => VideoCallController(), fenix: true);

    Get.lazyPut(() => PremiumController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut(() => EditJobPostDetailController(), fenix: true);
    Get.lazyPut(() => AplicationDetailController(), fenix: true);
    Get.lazyPut(() => SeeCandidateController(), fenix: true);
    Get.lazyPut(() => AplicationController(), fenix: true);
    Get.lazyPut(() => JobSeekerController(), fenix: true);
    Get.lazyPut(() => ResumeController(), fenix: true);
    Get.lazyPut(() => ResumeController(), fenix: true);
    Get.lazyPut(() => NavBarController(), fenix: true);

    // Job Seeker Controllers
    Get.lazyPut(() => JobSeekerUpdateProfileController(), fenix: true);
    Get.lazyPut(() => EmployerEditProfileController(), fenix: true);

    // Payment and Premium Controllers
    Get.lazyPut(() => ChoosePlanController(), fenix: true);
    Get.lazyPut(() => ViewUserDetailController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => IndividualChatController(), fenix: true);
    Get.lazyPut(() => UploadGalleryController(), fenix: true);
    Get.lazyPut(() => ImagePreviewController(), fenix: true);
    Get.lazyPut(() => EmployerHomeController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => FavoriteListController(), fenix: true);
    Get.lazyPut(() => ShowProfileVisitorController(), fenix: true);
    Get.lazyPut(() => EmployerEditProfileControllerForClient(), fenix: true);
    Get.put(SocketController(), permanent: true);
  }
}
