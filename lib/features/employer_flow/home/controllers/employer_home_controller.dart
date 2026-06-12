import 'dart:developer';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/chat/controllers/web_socket_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/employer_controller.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/models/get_emplooye_profile_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

class EmployerHomeController extends GetxController {
  var myPosts = <Map<String, dynamic>>[].obs;
  var recentApplied = <Map<String, dynamic>>[].obs;
  final socketController = Get.find<SocketController>();

  var username = "Loading...".obs;
  var isLoadingProfile = false.obs;
  var isLoadingApplied = false.obs;

  @override
  void onReady() {
    super.onReady();
    // getUserProfile();
    initAllData();
  }

  @override
  void onClose() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    print("Zego Call Service uninit done in onClose()");
    super.onClose();
  }

  // init all data
  String callType = "voice";
  int durationOfCall = 0;

  Future<void> initAllData() async {
    try {
      await getUserProfile();
      getEmployerAppliedJobList(isRefresh: true);
      await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: 267654701,
        appSign:
            "0eb6c4f7314e86e8781bfa3c5fd7c3a98b90d22bcf2f3cf61ebf17f8091ecb37",
        userID: AuthService.id.toString(),
        userName: username.value,
        plugins: [ZegoUIKitSignalingPlugin()],
        config: ZegoCallInvitationConfig(permissions: []),

        notificationConfig: ZegoCallInvitationNotificationConfig(
          androidNotificationConfig: ZegoCallAndroidNotificationConfig(
            callChannel: ZegoCallAndroidNotificationChannelConfig(
              channelID: "quick_job",
              channelName: "Call Notifications",
            ),
          ),
        ),

        requireConfig: (ZegoCallInvitationData data) {
          final config = (data.type == ZegoCallInvitationType.videoCall)
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

          final bool isVideo = data.type == ZegoCallInvitationType.videoCall;
          callType = isVideo ? "video" : "voice";

          config.duration.isVisible = true;

          config.duration.onDurationUpdate = (Duration duration) {
            durationOfCall = duration.inSeconds;
            log(
              "⏱️ Current Duration: ${duration.inSeconds} seconds Call type is : $callType",
            );
          };

          return config;
        },

        events: ZegoUIKitPrebuiltCallEvents(
          onCallEnd: (ZegoCallEndEvent event, void Function() defaultAction) {
            defaultAction();
            // final callID = event.callID;

            log(
              "Call ended. Reason: ${event.reason}, Duration: $durationOfCall}s",
            );
            // AppSnackBar.showSuccess(
            //   "Call End Duration is:$durationOfCall call type $callType",
            // );

            // Opposite user ID
            // Use your stored partner id here
            String otherUserId = socketController.currentCallPartnerId.value;
            log("call id is : $otherUserId");
            AppLoggerHelper.error("Call type is ; $callType");

            if (otherUserId.isNotEmpty) {
              socketController.sendPrivateMessage(
                user2Id: otherUserId,
                message: durationOfCall.toString(),
                messageType: (callType == "voice") ? "AUDIO" : "VIDEO",
              );
              socketController.currentCallPartnerId.value = "";
            }

            AppLoggerHelper.warning("call end event trigerd");
          },
        ),

        invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
          onIncomingCallReceived:
              (callID, inviter, type, invitees, customData) {
                log("Incoming call from: ${inviter.name}${inviter.id}");
              },
          onOutgoingCallDeclined: (callID, callee, customData) {
            AppLoggerHelper.warning("onOutGoing hit ${callee.name}");
            socketController.sendPrivateMessage(
              user2Id: callee.id,
              message: "0",
              messageType: (callType == "voice") ? "AUDIO" : "VIDEO",
            );
          },

          onOutgoingCallTimeout: (callID, callee, isVideoCall) {
            AppLoggerHelper.warning(
              "onOutGoing call time out hit $isVideoCall and ${callee[0].name}",
            );
            if (callee.isNotEmpty) {
              final user2Id = callee[0].id;
              socketController.sendPrivateMessage(
                user2Id: user2Id,
                message: "0",
                messageType: isVideoCall ? "VIDEO" : "AUDIO",
              );
            }
          },

          onError: (error) {
            if (socketController.showError.value) {
              // AppSnackBar.showError("This user is not register on app!");
              socketController.showError.value = false;
            }
            AppLoggerHelper.warning("error call end");

            AppLoggerHelper.error("Error: $error");
          },
        ),
      );

      // websocket
      socketController.connect();
      socketController.joinApp();
    } catch (e) {
      AppSnackBar.showError("App Init failed");
    }
  }

  final employerProfileData = EmplooyeProfileData().obs;

  String userId = "";
  Future<void> getUserProfile() async {
    try {
      isLoadingProfile.value = true;
      log("Fetching user profile...");

      final response = await NetworkCaller().getRequest(
        AppUrls.getProfile,
        token: "Bearer ${AuthService.token}",
      );

      if (response.statusCode == 200) {
        final modelData = GetEmployeeUserProfileModel.fromJson(
          response.responseData,
        );
        employerProfileData.value = modelData.result ?? EmplooyeProfileData();
        final data = response.responseData;
        if (data['success'] == true) {
          final userProfile = data['result'];

          log("User Profile Retrieved: $userProfile");
          username.value = userProfile['fullName'] ?? "User";
          userId = userProfile['id'] ?? "";
          await AuthService.saveId(id: userId);
          log("Auth user id is : ${AuthService.id}");

          log("Username set to: ${username.value}");
          log("Employee token : ${AuthService.token.toString()}");
        } else {
          // AppSnackBar.showError("Failed to retrieve user profile");
          username.value = "User";
        }
      } else {
        // AppSnackBar.showError("Failed to fetch user profile. Server error.");
        // log('Error: ${response.statusCode} - ${response.responseData}');
        username.value = "User";
      }
    } catch (e) {
      // AppSnackBar.showError("An error occurred: $e");
      log("Error fetching user profile: $e");
      username.value = "User";
    } finally {
      isLoadingProfile.value = false;
    }
  }

  var currentPage = 1.obs;
  var isPaginationLoading = false.obs;
  final perPageLimit = 10;
  Future<void> getEmployerAppliedJobList({bool isRefresh = false}) async {
    try {
      // if (isRefresh) {
      //   // currentPage.value = 1;
      //   // jobs.clear();
      //   // selectedCategory.value = "";
      //   // searchQuery.text = "";
      //   // locationController.text = "";
      //   // jobTypeValue.value = "";
      //   // salaryValue.value = 10000.0;
      // }

      // if (currentPage.value == 1) {
      //   isLoadingApplied.value = true;
      // } else {
      //   isPaginationLoading.value = true;
      // }

      // Map<String, dynamic> queryParams = {
      //   'page': currentPage.value.toString(),
      //   'limit': perPageLimit.toString(),
      // };

      // if (selectedCategory.value.isNotEmpty) {
      //   queryParams['category'] = selectedCategory.value;
      // }

      log("Fetching employer applied job list...");
      log("The token is: ${AuthService.token}");

      final response = await NetworkCaller().getRequest(
        AppUrls.getAllAppliedJobs,
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {
        final data = response.responseData;

        if (data != null && data['result'] != null) {
          final List<dynamic> appliedJobs = data['result']['data'] ?? [];

          log("Applied Jobs Retrieved: ${appliedJobs.length} items");

          recentApplied.clear();

          recentApplied.value = appliedJobs.map((applied) {
            return {
              "name":
                  applied['fullName'] ?? applied['name'] ?? 'Candidate Name',
              "title": applied['position'] ?? applied['title'] ?? 'Position',
              "image":
                  (applied['profileImage'] != null &&
                      applied['profileImage'].toString().isNotEmpty)
                  ? applied['profileImage']
                  : ImagePath.floydMiles,
              "id": applied['id'] ?? '',
              "userId": applied['userId'] ?? '',
              "jobId": applied['jobId'] ?? '',
              "status": applied['status'] ?? '',
            };
          }).toList();

          log(
            "Recent Applied List updated: ${recentApplied.length} candidates",
          );
        } else {
          log("No result data in response");
          recentApplied.value = [];
        }
      } else {
        // AppSnackBar.showError("Failed to fetch applied jobs");
        // log('Error: ${response.statusCode} - ${response.responseData}');
        recentApplied.value = [];
      }
    } catch (e) {
      // AppSnackBar.showError("Error loading applied jobs: $e");
      log("Error fetching applied job list: $e");
      recentApplied.value = [];
    } finally {
      isLoadingApplied.value = false;
    }
  }

  // deleted a job post
  Future<void> deleteJobPost({required String jobPostId}) async {
    try {
      loadingProgressIndicator();
      final response = await NetworkCaller().deleteRequest(
        AppUrls.deleteAJobPost(jobPostId: jobPostId),
        "Bearer ${AuthService.token.toString()}",
      );
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (response.isSuccess) {
        AppSnackBar.showSuccess("Job delete successful");
        final employCotroller = Get.find<EmployerController>();
        employCotroller.fetchJobPosts();
      } else {
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    }
  }
}
