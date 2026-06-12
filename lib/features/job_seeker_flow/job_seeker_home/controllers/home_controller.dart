import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/chat/controllers/web_socket_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/models/job_seeker_user_profile_model.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/models/nearby_job_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

class HomeController extends GetxController {
  var jobs = <NearbyJobModel>[].obs;
  var selectedNavIndex = 0.obs;
  var selectedCategory = "".obs;
  final socketController = Get.find<SocketController>();
  var username = "Sadia".obs;
  var address = "6391 Elgin St. Celina".obs;

  var categories = [
    {"title": "Cleaning", "icon": LogoPath.soap, "value": "CLEANING"},
    {
      "title": "Driver & Delivery",
      "icon": LogoPath.car,
      "value": "DRIVER_AND_DELIVERY",
    },
    {
      "title": "Kitchen Porter",
      "icon": LogoPath.knife,
      "value": "KITCHEN_PORTER",
    },
    // {"title": "Cleaning", "icon": LogoPath.soap, "value": "CLEANING"},
    // {
    //   "title": "Driver & Delivery",
    //   "icon": LogoPath.car,
    //   "value": "DRIVER_AND_DELIVERY",
    // },
    // {
    //   "title": "Kitchen Porter",
    //   "icon": LogoPath.knife,
    //   "value": "KITCHEN_PORTER",
    // },
  ].obs;

  var following = [
    {
      "title": "Designer",
      "location": "Dhaka",
      "distance": "5km",
      "icon": LogoPath.designer,
    },
    {
      "title": "Cleaning",
      "location": "Dhaka",
      "distance": "2km",
      "icon": LogoPath.cleaner,
    },
    {
      "title": "Driver & Delivery",
      "location": "Dhaka",
      "distance": "5km",
      "icon": LogoPath.driver,
    },
    {
      "title": "Designer",
      "location": "Dhaka",
      "distance": "5km",
      "icon": LogoPath.designer,
    },
    {
      "title": "Cleaning",
      "location": "Dhaka",
      "distance": "2km",
      "icon": LogoPath.cleaner,
    },
    {
      "title": "Driver & Delivery",
      "location": "Dhaka",
      "distance": "5km",
      "icon": LogoPath.driver,
    },
  ].obs;

  final scrollController = ScrollController();
  var isLoading = false.obs;
  var isJobLoading = false.obs;
  var isPaginationLoading = false.obs;
  var currentPage = 1.obs;
  final perPageLimit = 10;
  var totalItems = 0.obs;
  final searchQuery = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getUserProfile();
    // fetchJobs();
    initAllData();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
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
      fetchJobs();
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
                log("Incoming call from: ${inviter.name}");
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
              "onOutGoing call time out hit $isVideoCall  and ${callee[0].name}",
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

  final jobSeekerProfile = JobSeekerProfile().obs;

  Future<void> getUserProfile() async {
    try {
      // Get.dialog(
      //   Center(child: CircularProgressIndicator()),
      //   barrierDismissible: false,
      // );
      log("Fetching user profile...");
      log("token is : ${AuthService.token.toString()}");
      final response = await NetworkCaller().getRequest(
        AppUrls.getProfile,
        token: "Bearer ${AuthService.token}",
      );
      // Get.back();
      if (response.statusCode == 200 || response.isSuccess) {
        final modelData = GetJobSeekerUserProfileModel.fromJson(
          response.responseData,
        );
        jobSeekerProfile.value = modelData.result ?? JobSeekerProfile();
        final data = response.responseData;

        if (data['success'] == true) {
          final userProfile = data['result'];
          log("User Profile Retrieved: $userProfile");
          username.value = userProfile['fullName'] ?? "Oliver";
          log("User id for job seeker : ${userProfile['id']}");
          await AuthService.saveId(id: userProfile['id']);
          log("Auth servies saved id is : ${AuthService.id.toString()}");
          // AppSnackBar.showSuccess("User profile retrieved successfully");
        } else {
          // AppSnackBar.showError("Failed to retrieve user profile");
        }
      } else {
        // AppSnackBar.showError("Failed to fetch user profile. Server error.");
        AppLoggerHelper.info(
          'Error: ${response.statusCode} - ${response.responseData}',
        );
      }
    } catch (e) {
      // Get.back();
      // AppSnackBar.showError("An error occurred: $e");
      log("Error fetching user profile: $e");
    }
  }

  Future<void> fetchJobs({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        jobs.clear();
        selectedCategory.value = "";
        searchQuery.text = "";
        locationController.text = "";
        jobTypeValue.value = "";
        minSalary.value = 100.0;
        maxSalary.value = 100000.0;
      }

      if (currentPage.value == 1) {
        isJobLoading.value = true;
      } else {
        isPaginationLoading.value = true;
      }

      Map<String, dynamic> queryParams = {
        'page': currentPage.value.toString(),
        'limit': perPageLimit.toString(),
      };

      if (selectedCategory.value.isNotEmpty) {
        queryParams['category'] = selectedCategory.value;
      }

      if (searchQuery.text.isNotEmpty) {
        queryParams['searchQuery'] = searchQuery.text;
      }

      // adding filter query
      if (jobTypeValue.value.isNotEmpty) {
        queryParams['jobType'] = jobTypeValue.value;
      }

      if (locationController.text.isNotEmpty) {
        queryParams['location'] = locationController.text;
      }
      queryParams['salaryMin'] = minSalary.value;
      queryParams['salaryMax'] = maxSalary.value;
      ////////////////////
      log("Fetching jobs with params: $queryParams");

      final response = await NetworkCaller().getRequest(
        '${AppUrls.getAllJobs}?${_buildQueryString(queryParams)}',
        token: "Bearer ${AuthService.token}",
      );

      if (response.statusCode == 200) {
        final data = response.responseData;

        if (data['success'] == true) {
          final result = data['result'];
          final jobsList = result['data'] as List;
          final meta = result['meta'];
          totalItems.value = meta['total'] ?? 0;
          List<NearbyJobModel> fetchedJobs = jobsList.map((jobData) {
            final employerProfile = jobData['employeer_profile'] ?? {};
            final companyName =
                employerProfile['companyName'] ?? 'Unknown Company';
            final profileImage =
                employerProfile['user']?['profileImage'] ??
                LogoPath.sampleCompany;
            final userId = employerProfile['user']?['id'] ?? "";
            final userName = employerProfile['user']?['fullName'] ?? "NA";
            final isOnline = employerProfile['user']?['isOnline'] ?? 1;
            final lastOnlineAt = DateTime.parse(
              employerProfile['user']?['lastActivateAt'] ?? DateTime.now(),
            );
            final bool isLiked =
                (employerProfile['user']['likeReceive'] as List?)?.isNotEmpty ??
                false;

            return NearbyJobModel(
              isLiked: isLiked,
              isOnline: isOnline,
              lastOnlineAt: lastOnlineAt,
              userName: userName,
              profileImage: profileImage,
              title: jobData['position'] ?? 'Unknown Position',
              company: companyName,
              salary: jobData['salary'].toString(),
              location: jobData['location'] ?? 'Unknown Location',
              postedTime: jobData['postedTime'] ?? 'Recently',
              jobType: jobData['jobType'] ?? 'ON_SITE',
              jobCategory: jobData['JobCategory'] ?? '',
              requirements: List<String>.from(jobData['requirements'] ?? []),
              jobPostStatus: jobData['jobPostStatus'] ?? 'ACTIVE',
              id: jobData['id'] ?? '',
              userId: userId,
            );
          }).toList();

          if (isRefresh || currentPage.value == 1) {
            jobs.assignAll(fetchedJobs);
          } else {
            jobs.addAll(fetchedJobs);
          }

          log("Jobs fetched successfully: ${jobs.length}");
          // AppSnackBar.showSuccess("Jobs loaded successfully");
        } else if (response.statusCode == 403) {
          await AuthService.logoutUser();
          AppSnackBar.showError(
            "You are not authorized please login to continue",
          );
        } else {
          // AppSnackBar.showError(data['message'] ?? "Failed to fetch jobs");
        }
      } else {
        // AppSnackBar.showError("Server error: ${response.statusCode}");
        log('Error: ${response.statusCode} - ${response.responseData}');
      }
    } catch (e) {
      // AppSnackBar.showError("Error fetching jobs: $e");
      log("Error fetching jobs: $e");
    } finally {
      isJobLoading.value = false;
      isPaginationLoading.value = false;
    }
  }

  void selectCategory(String categoryValue) {
    selectedCategory.value = categoryValue;
    currentPage.value = 1;
    fetchJobs(isRefresh: true);
  }

  void searchJobs(String query) {
    searchQuery.text = query;
    currentPage.value = 1;
    fetchJobs(isRefresh: true);
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (jobs.length < totalItems.value && !isPaginationLoading.value) {
        currentPage.value++;
        fetchJobs();
      }
    }
  }

  String _buildQueryString(Map<String, dynamic> params) {
    return params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }

  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////
  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////
  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////
  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////

  RxDouble minSalary = 100.0.obs;
  RxDouble maxSalary = 100000.0.obs;

  final NumberFormat formatter = NumberFormat('#,##,###');

  String get formattedSalaryMin {
    return formatter.format(minSalary.value);
  }

  String get formattedSalaryMax {
    return formatter.format(maxSalary.value);
  }

  // final categoryList = [
  //   "Flutter",
  //   "Logo maker",
  //   "Car driver",
  //   "Other",
  //   "All",
  // ].obs;
  // final categoryValue = "Flutter".obs;
  // void changeCategoryValue(String value) {
  //   categoryValue.value = value;
  // }

  final jobTypeList = ["REMOTE", "HYBRID", "ON_SITE"].obs;
  final jobTypeValue = "".obs;
  void changeJobTypeValue(String value) {
    jobTypeValue.value = value;
  }

  // final languageList = ["Bangla", "English"].obs;
  // final languageValue = "Bangla".obs;
  // void changeLanguageValue(String value) {
  //   languageValue.value = value;
  // }

  final locationController = TextEditingController();
}
