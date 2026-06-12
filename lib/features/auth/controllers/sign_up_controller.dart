import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/auth/views/screens/otp_varification_screen.dart';
import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';

class SignUpController extends GetxController {
  final companyNameTEController = TextEditingController();
  final companyEmailTEController = TextEditingController();
  final companyPhoneTEController = TextEditingController();
  final companyAddressTEController = TextEditingController();
  final companyCountryTEController = TextEditingController();
  final zipCodeTEController = TextEditingController();
  final websiteTEController = TextEditingController();
  final companyEstablishTEController = TextEditingController();
  final addressTEController = TextEditingController();
  final industryTEController = TextEditingController();
  final descriptionTEController = TextEditingController();

  void troggleStatus(String item) {
    selectedStatus.value = item;
  }

  var selectedStatus = 'Owner'.obs;
  var selectedRole = "".obs;
  void setRole(String role) {
    selectedRole.value = role;
  }

  final statusList = ['Owner', 'HR', 'Project Manager'].obs;
  final TextEditingController fullNameTEController = TextEditingController();
  final TextEditingController phoneTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  DateTime? selectedDate;

  var roleEnums = {"JOB SEEKERS": "JOB_SEEKERS", "EMPLOYER": "EMPLOYEER"};

  var employeRole = {
    "Owner": "OWNER",
    "HR": "HR",
    "Project Manager": "PROJECT_MANAGER",
  };

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    String? role;

    if (args is Map && args.containsKey('role')) {
      role = args['role'] as String?;
    } else if (args is String) {
      role = args;
    }

    if (role != null) {
      selectedRole.value = role;
      log('Selected Role Display Name: ${selectedRole.value}');
      log('Backend Role Value: ${roleEnums[selectedRole.value]}');
    } else {
      selectedRole.value = "EMPLOYER";
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? signupToken;

  Future<void> requestToRegisterAccount() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log("Token is  $fcmToken");
    try {
      if (fullNameTEController.text.isEmpty ||
          emailTEController.text.isEmpty ||
          passwordTEController.text.isEmpty ||
          phoneTEController.text.isEmpty ||
          companyNameTEController.text.isEmpty ||
          descriptionTEController.text.isEmpty) {
        log(emailTEController.text);
        AppSnackBar.showError('Please fill in all the required fields.');
        return;
      }

      final backendRole = AuthService.role.toString();

      final backendEmployRole = employeRole[selectedStatus.value] ?? "OWNER";

      // String? formattedEstablishDate = (selectedDate != null)
      //     ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedDate!)
      //     : "";

      final requestBody = {
        "fullName": fullNameTEController.text.isNotEmpty
            ? fullNameTEController.text
            : "",
        "email": emailTEController.text.isNotEmpty
            ? emailTEController.text.toLowerCase()
            : "",
        "password": passwordTEController.text.isNotEmpty
            ? passwordTEController.text
            : "",
        "phoneNumber": phoneTEController.text.isNotEmpty
            ? phoneTEController.text
            : "",
        "role": backendRole,
        "employRole": backendEmployRole,
        "companyName": companyNameTEController.text.isNotEmpty
            ? companyNameTEController.text
            : "",
        "companyEmail": companyEmailTEController.text.isNotEmpty
            ? companyEmailTEController.text
            : "",
        "companyPhoneNumber": companyPhoneTEController.text.isNotEmpty
            ? companyPhoneTEController.text
            : "",
        "companyWebsite": websiteTEController.text.isNotEmpty
            ? websiteTEController.text
            : "",
        "companyAddress": companyAddressTEController.text.isNotEmpty
            ? companyAddressTEController.text
            : "",
        "companyCountry": companyCountryTEController.text.isNotEmpty
            ? companyCountryTEController.text
            : "",
        "companyZipCode": zipCodeTEController.text.isNotEmpty
            ? zipCodeTEController.text
            : "",
        "companyEstablishDate": isoFormatDate,
        // "industry": industryTEController.text.isNotEmpty
        //     ? industryTEController.text
        //     : null,
        "industry": "TECH",
        "desc": descriptionTEController.text.isNotEmpty
            ? descriptionTEController.text
            : "",
        "fcmToken": fcmToken ?? "",
      };

      loadingProgressIndicator(title: "Register");

      final response = await NetworkCaller().postRequest(
        AppUrls.signUp,
        body: requestBody,
      );
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // log('Response: ${response.responseData}');

      if (response.isSuccess) {
        signupToken = response.responseData['result']['token'];
        if (signupToken != null && signupToken!.isNotEmpty) {
          await AuthService.saveToken(token: signupToken!);
          log('Signup token saved: $signupToken');
        }
        // signupToken = response.responseData['result']['token'];

        // Get.back();
        final data = response.responseData;

        log('Full Response Data: $data');

        if (data != null && data['data'] != null) {
          if (data['data']['token'] != null) {
            await AuthService.saveToken(token: data['data']['token']);
          }

          if (data['data']['role'] != null) {
            await AuthService.saveRole(role: data['data']['role'].toString());
          }
          if (data['data']['id'] != null) {
            await AuthService.saveId(id: data['data']['id'].toString());
          }
        }

        Get.to(
          () => OtpVerificationScreen(),
          arguments: {'email': emailTEController.text.toLowerCase()},
          //     arguments: {
          //
          //   'email': email.value.toLowerCase(), // Pass the signup email
          //   'reason': OtpReason.signupOtp,
          // }
        );
        AppSnackBar.showSuccess("Account registered successfully");
      } else if (response.statusCode == 409) {
        Get.back();
        AppSnackBar.showSuccess('User already exists. Please try to login');
      } else if (response.statusCode == 500) {
        Get.back();
        Future.microtask(() async {
          await Future.delayed(const Duration(milliseconds: 200));
          if (Get.isDialogOpen == false) {
            AppSnackBar.showError("Phone number or email already taken");
          }
        });
      } else {
        Get.back();
        AppSnackBar.showError('Error: Something went wrong');
      }
    } catch (error) {
      Get.back();
      AppLoggerHelper.error('Error during registration: ${error.toString()}');
      AppSnackBar.showError('Please try again later!');
    }
  }

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
      companyEstablishTEController.text = DateFormat('dd/MM/yyyy').format(date);
    }
  }

  // Country Picker
  void pickCountry(BuildContext context) async {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        companyCountryTEController.text = country.name;
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

  // @override
  // void onClose() {
  //   fullNameTEController.dispose();
  //   phoneTEController.dispose();
  //   emailTEController.dispose();
  //   passwordTEController.dispose();
  //   companyNameTEController.dispose();
  //   companyEmailTEController.dispose();
  //   companyPhoneTEController.dispose();
  //   companyAddressTEController.dispose();
  //   companyCountryTEController.dispose();
  //   zipCodeTEController.dispose();
  //   websiteTEController.dispose();
  //   companyEstablishTEController.dispose();
  //   industryTEController.dispose();
  //   descriptionTEController.dispose();
  //   super.onClose();
  // }
}
