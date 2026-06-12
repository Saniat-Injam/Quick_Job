import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/common/widgets/loading_progress_indicator.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../views/screens/otp_varification_screen.dart';

class JobSeekerController extends GetxController {
  var seletedType = 'MALE'.obs;
  final genderType = ['MALE', 'FEMALE'].obs;

  void seletedTroggleType(item) {
    seletedType.value = item;
  }

  var languageType = 'ENGLISH'.obs;
  final language = ['ENGLISH', 'SPANISH'].obs;

  void seletedlanguageType(item) {
    languageType.value = item;
  }

  var nativeLanguage = 'ENGLISH'.obs;
  final native = ['ENGLISH', 'SPANISH'].obs;

  void seletedNativeType(item) {
    nativeLanguage.value = item;
  }

  var jobExperienceType = 'ZERO_TO_ONE'.obs;
  final jobExperienceOptions = [
    'ZERO_TO_ONE',
    'ONE_TO_THREE',
    'THREE_TO_FIVE',
    'FIVE_PLUS',
  ].obs;

  void selectedJobExperience(item) {
    jobExperienceType.value = item;
  }

  DateTime? selectedDate;
  final dateTEController = TextEditingController();

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
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
      dateTEController.text = DateFormat('dd/MM/yyyy').format(date);
    }
  }

  var roleEnums = {"JOB_SEEKERS": "JOB_SEEKERS", "EMPLOYER": "EMPLOYEER"};

  final fullNameTEController = TextEditingController();
  final phoneNumberTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final educationTEController = TextEditingController();
  final ageTEController = TextEditingController();
  final genderTEController = TextEditingController();
  final dobTEController = TextEditingController();
  final addressTEController = TextEditingController();
  final occupationTEController = TextEditingController();
  final descTEController = TextEditingController();
  final jobExperinceTEController = TextEditingController();
  final languageNativeTEController = TextEditingController();
  final languageProfessionalTEController = TextEditingController();
  final emailTEController = TextEditingController();

  var selectedRole = "EMPLOYER".obs;
  String? signupToken;

  Future<void> jobSeekerSignUp() async {
    try {
      String? formattedDob;
      if (selectedDate != null) {
        formattedDob = DateFormat(
          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
        ).format(selectedDate!);
      }

      int? age;
      if (ageTEController.text.isNotEmpty) {
        age = int.tryParse(ageTEController.text);
      }
      final Map<String, dynamic> requestBody = {
        "role": "JOB_SEEKERS",
        "fullName": fullNameTEController.text.trim(),
        "email": emailTEController.text.trim().toLowerCase(),
        "phoneNumber": phoneNumberTEController.text.trim(),
        "password": passwordTEController.text,
        "education": educationTEController.text.trim(),
        "age": age, // Using parsed age
        "gender": seletedType.value.isEmpty ? null : seletedType.value,
        "dob": formattedDob,
        "address": addressTEController.text.trim(),
        "occupation": occupationTEController.text.trim(),
        "desc": descTEController.text.trim(),
        "jobExperince": jobExperienceType.value.isEmpty
            ? null
            : jobExperienceType.value,
        "languageNative": nativeLanguage.value.isEmpty
            ? null
            : nativeLanguage.value,
        "languageProfessional": languageType.value.isEmpty
            ? null
            : languageType.value,
      };
      requestBody.removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty),
      );
      log('Request Body: $requestBody');
      loadingProgressIndicator(title: "Register");

      final response = await NetworkCaller().postRequest(
        AppUrls.signUp,
        body: requestBody,
      );

      log('Response: ${response.responseData}');

      if (response.isSuccess) {
        Get.back();

        final data = response.responseData;
        final token = data['result']['token'];

        log('Full Response Data: $data');

        if (data != null) {
          if (data['result'] != null && data['result']['token'] != null) {
            signupToken = data['result']['token'];
            await AuthService.saveToken(token: signupToken!);
            log('Signup token saved: $signupToken');
          } else if (data['data'] != null && data['data']['token'] != null) {
            await AuthService.saveToken(token: data['data']['token']);
          }

          if (data['data'] != null) {
            if (data['data']['role'] != null) {
              await AuthService.saveRole(role: data['data']['role'].toString());
            }
            if (data['data']['id'] != null) {
              await AuthService.saveId(id: data['data']['id'].toString());
            }
          }
        }

        Get.to(
          () => OtpVerificationScreen(),
          arguments: {
            'email': emailTEController.text.trim().toLowerCase(),
            'token': token,
          },
        );

        AppSnackBar.showSuccess("Account registered successfully");
      } else if (response.statusCode == 409) {
        Get.back();
        AppSnackBar.showError('User already exists. Please try to login');
      } else if (response.statusCode == 500) {
        Get.back();
        AppSnackBar.showError("Phone number or email already taken");
      } else {
        Get.back();
        AppSnackBar.showError(response.errorMessage);
      }
    } catch (error) {
      Get.back();
      AppLoggerHelper.error('Error during registration: ${error.toString()}');
      AppSnackBar.showError('An error occurred. Please try again later.');
    }
  }

  @override
  void onClose() {
    fullNameTEController.dispose();
    phoneNumberTEController.dispose();
    passwordTEController.dispose();
    educationTEController.dispose();
    ageTEController.dispose();
    genderTEController.dispose();
    dobTEController.dispose();
    addressTEController.dispose();
    occupationTEController.dispose();
    descTEController.dispose();
    jobExperinceTEController.dispose();
    languageNativeTEController.dispose();
    languageProfessionalTEController.dispose();
    emailTEController.dispose();
    dateTEController.dispose();
    super.onClose();
  }
}
