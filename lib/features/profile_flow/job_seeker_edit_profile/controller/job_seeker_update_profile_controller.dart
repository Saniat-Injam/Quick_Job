import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/controllers/home_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/profile_controller.dart';

class JobSeekerUpdateProfileController extends GetxController {
  // for page swapping
  final currentIndex = 0.obs;

  void next() {
    if (currentIndex.value < 2) {
      currentIndex.value++;
      log(currentIndex.value.toString());
    } else {
      log("no more page: ${currentIndex.value}");
      log("api hit : ${currentIndex.value}");
      updateProfile();
    }
  }

  void back() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      log(currentIndex.value.toString());
    } else {
      log("No back page found ; ${currentIndex.value}");
    }
  }

  Rx<File?> selectedUserImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImageForUser() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked != null) {
      selectedUserImage.value = File(picked.path);
      profileImageUrl.value = "";
      log(isVideo.value.toString());
    }
  }

  final NetworkCaller _networkCaller = NetworkCaller();

  /// Loading state
  RxBool isUpdatingProfile = false.obs;

  /// Text Controllers
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final occupationController = TextEditingController();
  final descriptionController = TextEditingController();
  final educationController = TextEditingController();
  final profileImageUrl = "".obs;

  var jobExperienceType = 'ZERO_TO_ONE'.obs;
  final jobExperienceOptions = [
    'ZERO_TO_ONE',
    'TWO_TO_FIVE',
    'FIVE_TO_TEN',
    'TEN_PLUS',
  ].obs;

  void selectedJobExperience(item) {
    jobExperienceType.value = item;
  }

  /// Dropdowns
  RxString gender = ''.obs;
  RxString professionalLang = ''.obs;
  RxString nativeLang = ''.obs;

  /// File
  Rx<File?> selectedFile = Rx<File?>(null);

  String get selectedFileName => selectedFile.value == null
      ? ''
      : selectedFile.value!.path.split('/').last;

  String get selectedFileSize {
    if (selectedFile.value == null) return '';
    final bytes = selectedFile.value!.lengthSync();
    return "${(bytes / 1024 / 1024).toStringAsFixed(2)} MB";
  }

  /// Pick CV file
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      isCv(false);
    }
  }

  /// Remove file
  void deleteFile() {
    selectedFile.value = null;
  }

  /// Update Profile
  Future<void> updateProfile() async {
    try {
      if (!_validate()) return;
      // isUpdatingProfile.value = true;
      loadingProgressIndicator();

      // Build nested data object
      final Map<String, dynamic> data = {
        "fullName": fullNameController.text.trim(),
        "role": AuthService.role,
        // "email": emailController.text.trim(),
        "age": int.tryParse(ageController.text.trim()) ?? 0,
        "gender": gender.value,
        "dob": "${DateTime.parse(dobController.text).toIso8601String()}Z",
        "address": addressController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
        "occupation": occupationController.text.trim(),
        "desc": descriptionController.text.trim(),
        "education": educationController.text.trim(),
        "jobExperince": jobExperienceType.value,
        "languageNative": professionalLang.value,
        "languageProfessional": nativeLang.value,
      };

      final response = await _networkCaller.patchMultipartRequest(
        AppUrls.jobSeekerProfileUpdate,
        data: data,
        resumeFile: selectedFile.value,
        introVideo: videoPath.value,
        profileImage: selectedUserImage.value,
      );

      if (response.isSuccess) {
        // Get.snackbar(
        //   "Success",
        //   "Profile updated successfully",
        //   backgroundColor: Colors.green.shade600,
        //   colorText: Colors.white,
        // );

        final profileController = Get.find<ProfileController>();
        await profileController.getMe();
        await homeController.getUserProfile();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.back();
        AppSnackBar.showSuccess("Profile updated successfully");
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppLoggerHelper.error("Error");
        AppSnackBar.showError("Try again later");
        // Get.snackbar(
        //   "Error",
        //   response.errorMessage,
        //   backgroundColor: Colors.red.shade600,
        //   colorText: Colors.white,
        // );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppLoggerHelper.error("Error $e");
      // Get.snackbar(
      //   "Error",
      //   "Unexpected error occurred",
      //   backgroundColor: Colors.red.shade600,
      //   colorText: Colors.white,
      // );
      AppSnackBar.showError("Unexpected error occurred");
    }
  }

  /// Validation
  bool _validate() {
    if (AuthService.role == null) {
      _error("User role not found. Please re-login.");
      return false;
    }

    if (nativeLang.value.isEmpty) {
      _error("Native language not be empty");
      return false;
    }
    if (professionalLang.value.isEmpty) {
      _error("Professional language not be empty");
      return false;
    }
    if (gender.value.isEmpty) {
      _error("Select gender");
      return false;
    }
    // if (videoPath.value == null && (videoPath.value?.path ?? "").isEmpty) {
    //   _error("Select a video");
    //   return false;
    // }
    // if (selectedFile.value == null &&
    //     (selectedFile.value?.path ?? "").isEmpty) {
    //   _error("Select a CV");
    //   return false;
    // }
    if (jobExperienceType.value.isEmpty) {
      _error("Select any experience type");
      return false;
    }
    return true;
  }

  void _error(String msg) {
    AppSnackBar.showError("Validation error : $msg");
    // Get.snackbar(
    //   "Validation Error",
    //   msg,
    //   backgroundColor: Colors.orange.shade600,
    //   colorText: Colors.white,
    // );
  }

  //////////////////////////////////////////
  ///
  Rx<File?> videoPath = Rx<File?>(null);

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video == null) return;

    videoPath.value = File(video.path);
    isVideo(false);
  }

  final homeController = Get.find<HomeController>();
  final isVideo = false.obs;
  final isCv = false.obs;
  @override
  void onInit() {
    super.onInit();
    final userData = homeController.jobSeekerProfile.value;
    profileImageUrl.value = userData.profileImage ?? "";
    fullNameController.text = userData.fullName ?? "NA";
    ageController.text = (userData.jobSeekersProfile?.age ?? 0).toString();
    gender.value = userData.jobSeekersProfile?.gender ?? "MALE";
    dobController.text = DateFormat(
      'yyyy-MM-dd',
    ).format(userData.jobSeekersProfile?.dob ?? DateTime.now());
    // emailController.text = userData.email ?? "NA";
    addressController.text = userData.jobSeekersProfile?.address ?? "NA";
    phoneController.text = userData.phoneNumber ?? "NA";
    occupationController.text = userData.jobSeekersProfile?.occupation ?? "NA";
    descriptionController.text = userData.jobSeekersProfile?.desc ?? "NA";
    educationController.text = userData.jobSeekersProfile?.education ?? "NA";
    jobExperienceType.value =
        userData.jobSeekersProfile?.jobExperince ?? "ZERO_TO_ONE";
    professionalLang.value =
        userData.jobSeekersProfile?.languageProfessional ?? "ENGLISH";
    nativeLang.value = userData.jobSeekersProfile?.languageNative ?? "ENGLISH";

    isVideo.value = userData.introVideo?.isNotEmpty ?? false;

    isCv.value =
        (userData.jobSeekersProfile?.jobSeekersResume?.isNotEmpty ?? false)
        ? (userData.jobSeekersProfile!.jobSeekersResume!
                  .firstWhere(
                    (e) => e.isSelected == true,
                    orElse: () =>
                        userData.jobSeekersProfile!.jobSeekersResume!.first,
                  )
                  .resumeUrl
                  ?.isNotEmpty ??
              false)
        : false;
  }

  // @override
  // void onClose() {
  //   fullNameController.dispose();
  //   ageController.dispose();
  //   emailController.dispose();
  //   dobController.dispose();
  //   addressController.dispose();
  //   occupationController.dispose();
  //   descriptionController.dispose();
  //   educationController.dispose();
  //   experienceController.dispose();
  //   super.onClose();
  // }
}
