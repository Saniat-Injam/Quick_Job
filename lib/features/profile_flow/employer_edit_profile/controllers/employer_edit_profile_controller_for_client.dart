import 'dart:developer';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/employer_flow/home/controllers/employer_home_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/profile_controller.dart';

class EmployerEditProfileControllerForClient extends GetxController {
  // all variable
  Rx<File?> selectedUserImage = Rx<File?>(null);
  Rx<File?> selectedCompanyLogoImage = Rx<File?>(null);

  // all textEditing controller
  // 1st screen

  final ImagePicker _picker = ImagePicker();
  Future<void> pickImageForUser() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked != null) {
      selectedUserImage.value = File(picked.path);
    }
  }

  Future<void> pickImageForCompanyLogo() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked != null) {
      selectedCompanyLogoImage.value = File(picked.path);
    }
  }

  // Rx<File?> videoPath = Rx<File?>(null);
  // final videoName = "".obs;

  // Future<void> pickVideo() async {
  //   final picker = ImagePicker();
  //   final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

  //   if (video == null) return;

  //   videoPath.value = File(video.path);
  //   videoName.value = video.name;
  // }

  // Country Picker
  void pickCountry(BuildContext context) async {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        companyCountryController.text = country.name;
        print('Selected country: ${country.name}');
      },
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search Country',
          hintText: 'Start typing to search...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  var isoFormatDate = '';
  // Date Picker
  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(
        1900,
      ), // Changed to allow past dates for establishment date
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              headlineMedium: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
              bodyLarge: GoogleFonts.inter(fontSize: 16.sp, color: Colors.teal),
            ),
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textWhite,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      selectedDate = date;
      isoFormatDate = date.toUtc().toIso8601String();
      companyDateController.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

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

  // api integration
  final NetworkCaller _networkCaller = NetworkCaller();

  /// Loading
  RxBool isUpdatingProfile = false.obs;
  final homeController = Get.find<EmployerHomeController>();

  /// Text Controllers
  // final companyNameController = TextEditingController();
  // final yourNameController = TextEditingController();
  // final emailController = TextEditingController();
  // final establishedDateController = TextEditingController();
  // final countryController = TextEditingController();
  // final addressController = TextEditingController();
  // final phoneNumberController = TextEditingController();

  final fullNameController = TextEditingController();
  // final yourRoleController = TextEditingController();
  // final phoneNumberController = TextEditingController();

  // 2nd screen
  final companyNameController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyPhoneController = TextEditingController();
  // final companyBuisnessType = TextEditingController();
  final companyDateController = TextEditingController();

  //3rd screen
  final companyAddressController = TextEditingController();
  final companyCountryController = TextEditingController();
  final companyZipCodeController = TextEditingController();
  final companyDescController = TextEditingController();
  final companyWebsiteController = TextEditingController();

  Future<void> updateProfile() async {
    try {
      loadingProgressIndicator();
      // Flatten the body according to model fields
      final DateTime parsedDate = DateFormat(
        'd-M-yyyy',
      ).parseStrict(companyDateController.text);

      // Step 2a: ISO 8601 string (backend ready)
      final String dobIso = parsedDate
          .toIso8601String(); // 2026-01-01T00:00:00.000

      final Map<String, dynamic> body = {
        "fullName": fullNameController.text.trim(),
        "companyName": companyNameController.text.trim(),
        "companyEmail": companyEmailController.text.trim(),
        "role": AuthService.role,
        "companyEstablishDate": "${dobIso}Z",
        "companyCountry": companyCountryController.text.trim(),
        "companyAddress": companyAddressController.text.trim(),
        "industry": "TECH",
        //new
        "employRole": selctedCompanyRole.value,
        "desc": companyDescController.text,
        "companyPhoneNumber": companyPhoneController.text,
        "companyZipCode": companyZipCodeController.text,
        "companyWebsite": companyWebsiteController.text,
        "phoneNumber": companyPhoneController.text,
      };
      log(body.toString());

      final response = await _networkCaller.patchMultipartRequest(
        AppUrls.employerProfileUpdate,
        data: body,
        // introVideo: videoPath.value,
        // profileImage: selectedCompanyLogoImage.value,
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
    companyEmailController.text = employerData?.companyEmail ?? "NA";

    companyDescController.text = employerData?.desc ?? "NA";
    companyDateController.text = DateFormat(
      'd-M-yyyy',
    ).format(employerData?.companyEstablishDate ?? DateTime.now());
    companyCountryController.text = employerData?.companyCountry ?? "NA";
    companyAddressController.text = employerData?.companyAddress ?? "NA";
    fullNameController.text =
        homeController.employerProfileData.value.fullName ?? "NA";
    isVideo.value =
        homeController.employerProfileData.value.introVideo?.isNotEmpty ??
        false;
    log("video ; ${isVideo.value}");

    // new
    companyWebsiteController.text = employerData?.companyWebsite ?? "";
    companyZipCodeController.text = employerData?.companyZipCode ?? "";
    companyPhoneController.text = employerData?.companyPhoneNumber ?? "";
    selctedCompanyRole.value = employerData?.employRole ?? "OWNER";
    companyZipCodeController.text = employerData?.companyZipCode ?? "";
    companyPhoneController.text =
        homeController.employerProfileData.value.phoneNumber ?? "";
  }

  // final descriptionTEController = TextEditingController();
  // final zipCodeTEController = TextEditingController();
  // final websiteTEController = TextEditingController();
  // final companyPhoneTEController = TextEditingController();

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
    companyEmailController.text = email;
    companyCountryController.text = country;
    companyAddressController.text = address;
    companyDateController.text = establishedDate;
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
}
