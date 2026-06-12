import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/chat/models/get_employer_profile_detail_model.dart';
import 'package:quick_job/features/chat/models/get_job_seeker_profile_model.dart';
import 'package:video_player/video_player.dart';

class ViewUserDetailController extends GetxController {
  String userId = "";
  // get user profile
  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments['userId'] ?? "";
    getUserProfile(userId: userId);
  }

  final isUserLoading = false.obs;
  final detailUserRole = "".obs;
  final emplooyerProfileDetails = EmployerDetailsProfile().obs;
  final jobSeekerProfileDetails = JobSeekerDetailsProfile().obs;

  // hit user profile api
  Future<void> getUserProfile({required String userId}) async {
    try {
      if (userId.isEmpty) {
        AppSnackBar.showError("User id not found please try again later");
        return;
      }
      isUserLoading(true);
      final response = await NetworkCaller().getRequest(
        AppUrls.getOtherUserProfile(userId: userId),
      );
      if (response.isSuccess) {
        AppLoggerHelper.info("Other user fetch successful : $userId");
        final data = response.responseData;
        final role = data['result']['role'] ?? "";
        detailUserRole.value = role;
        log(
          "User role is : ${detailUserRole.value} and server value is: $role",
        );
        if (role == "JOB_SEEKERS") {
          final modelData = GetJobSeekerProfileDetailsModel.fromJson(
            response.responseData,
          );
          jobSeekerProfileDetails.value =
              modelData.result ?? JobSeekerDetailsProfile();
          AppLoggerHelper.warning("For job seeker");
          final videoUrl = jobSeekerProfileDetails.value.introVideo;

          if (videoUrl != null && videoUrl.isNotEmpty) {
            init(videoUrl);
          }
        } else {
          final modelData = GetJobEmployeerProfileDetailsModel.fromJson(
            response.responseData,
          );
          emplooyerProfileDetails.value =
              modelData.result ?? EmployerDetailsProfile();
          AppLoggerHelper.warning("For employer");
          final videoUrl = emplooyerProfileDetails.value.introVideo;

          if (videoUrl != null && videoUrl.isNotEmpty) {
            init(videoUrl);
          }
        }
      } else {
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    } finally {
      isUserLoading(false);
    }
  }

  // for intro video
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  void init(String videoUrl) {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    );

    videoPlayerController!
        .initialize()
        .then((_) {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController!,
            autoPlay: false,
            looping: false,
            allowFullScreen: false,
            allowMuting: true,
            showControls: true,
            aspectRatio: videoPlayerController!.value.aspectRatio,
          );
          update();
        })
        .catchError((e) {
          log("VIDEO INIT ERROR: $e");
        });
  }

  // @override
  // void onClose() {
  //   cleanUpController();
  //   super.onClose();
  // }

  void cleanUpController() {
    videoPlayerController?.pause();
    chewieController?.dispose();
    videoPlayerController?.dispose();
    log("cleanup successful");
  }
}
