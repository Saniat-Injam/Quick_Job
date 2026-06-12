import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/employer_flow/home/controllers/employer_home_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/profile_controller.dart';

class EmployerEditProfileController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  /// Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Loading
  RxBool isUpdatingProfile = false.obs;
  final homeController = Get.find<EmployerHomeController>();

  /// Text Controllers
  final companyNameController = TextEditingController();
  final yourNameController = TextEditingController();
  final emailController = TextEditingController();
  final establishedDateController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // new

  Future<void> updateProfile() async {
    // FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) return;

    try {
      loadingProgressIndicator();
      // Flatten the body according to model fields
      final DateTime parsedDate = DateFormat(
        'd-M-yyyy',
      ).parseStrict(establishedDateController.text);

      // Step 2a: ISO 8601 string (backend ready)
      final String dobIso = parsedDate
          .toIso8601String(); // 2026-01-01T00:00:00.000

      final Map<String, dynamic> body = {
        "fullName": yourNameController.text.trim(),
        "companyName": companyNameController.text.trim(),
        "companyEmail": emailController.text.trim(),
        "role": AuthService.role,
        "companyEstablishDate": "${dobIso}Z",
        "companyCountry": countryController.text.trim(),
        "companyAddress": addressController.text.trim(),
        "industry": "TECH",
        //new
        "employRole": selctedCompanyRole.value,
        "desc": descriptionTEController.text,
        "companyPhoneNumber": companyPhoneTEController.text,
        "companyZipCode": zipCodeTEController.text,
        "companyWebsite": websiteTEController.text,
        "phoneNumber": phoneNumberController.text,
      };
      log(body.toString());

      final response = await _networkCaller.patchMultipartRequest(
        AppUrls.employerProfileUpdate,
        data: body,
        introVideo: videoPath.value,
      );

      if (response.isSuccess) {
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
        AppSnackBar.showError(
          "Error: ${response.responseData?['errors']?[0]?['message'] ?? response.responseData?['message'] ?? 'Something went wrong'}",
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError("Something went wrong");
      AppLoggerHelper.error("Error : $e");
    }
  }

  final isVideo = false.obs;
  @override
  void onInit() {
    super.onInit();
    final employerData =
        homeController.employerProfileData.value.employerProfile;
    companyNameController.text = employerData?.companyName ?? "NA";
    emailController.text = employerData?.companyEmail ?? "NA";
    establishedDateController.text = DateFormat(
      'd-M-yyyy',
    ).format(employerData?.companyEstablishDate ?? DateTime.now());
    countryController.text = employerData?.companyCountry ?? "NA";
    addressController.text = employerData?.companyAddress ?? "NA";
    yourNameController.text =
        homeController.employerProfileData.value.fullName ?? "NA";
    isVideo.value =
        homeController.employerProfileData.value.introVideo?.isNotEmpty ??
        false;
    log("video ; ${isVideo.value}");

    // new
    websiteTEController.text = employerData?.companyWebsite ?? "";
    zipCodeTEController.text = employerData?.companyZipCode ?? "";
    companyPhoneTEController.text = employerData?.companyPhoneNumber ?? "";
    selctedCompanyRole.value = employerData?.employRole ?? "OWNER";
    descriptionTEController.text = employerData?.desc ?? "";
    phoneNumberController.text =
        homeController.employerProfileData.value.phoneNumber ?? "";
  }

  final descriptionTEController = TextEditingController();
  final zipCodeTEController = TextEditingController();
  final websiteTEController = TextEditingController();
  final companyPhoneTEController = TextEditingController();

  final companyRole = ['OWNER', 'HR', 'PROJECT_MANAGER'].obs;
  final selctedCompanyRole = "OWNER".obs;
  void changeCompanyRole(String value) {
    selctedCompanyRole.value = value;
  }

  void prefillData({
    required String name,
    required String email,
    required String country,
    required String address,
    required String establishedDate,
  }) {
    companyNameController.text = name;
    emailController.text = email;
    countryController.text = country;
    addressController.text = address;
    establishedDateController.text = establishedDate;
  }

  // @override
  // void onClose() {
  //   companyNameController.dispose();
  //   emailController.dispose();
  //   establishedDateController.dispose();
  //   countryController.dispose();
  //   addressController.dispose();
  //   super.onClose();
  // }

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
}
