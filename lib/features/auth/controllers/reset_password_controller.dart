import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/routes/app_routes.dart';

import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class OTPReason {
  static const String signupOtp = "SIGNUP_OTP_SECRET";
  static const String loginOtp = "LOGIN_OTP_SECRET";
  static const String resetPassword = "RESET_PASSWORD_SECRET";
  static const String forgetPassword = "FORGET_PASSWORD_SECRET";

  static String getMessage(String reason) {
    switch (reason) {
      case signupOtp:
        return "Sign up";
      case loginOtp:
        return "Login";
      case resetPassword:
        return "Reset password";
      case forgetPassword:
        return "Forgot password";
      default:
        return "Verification";
    }
  }

  /// Validate if reason is valid
  static bool isValid(String reason) {
    return [
      signupOtp,
      loginOtp,
      resetPassword,
      forgetPassword,
    ].contains(reason);
  }
}

class ResetPasswordController extends GetxController {
  final TextEditingController emailPhoneController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> sendForgotPasswordOTP(String email) async {
    try {
      if (email.trim().isEmpty) {
        AppSnackBar.showError("Please enter your email");
        return;
      }
      loadingProgressIndicator();
      final response = await NetworkCaller().postRequest(
        AppUrls.forgotPassword,
        body: {"email": email.toLowerCase().trim()},
      );

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.isSuccess) {
        final responseBody = response.responseData;

        final token = responseBody['result']?['token'];

        if (token == null || token.isEmpty) {
          AppSnackBar.showError("Failed to get verification token");
          log('Error: verifyToken is null or empty');
          return;
        }
        await AuthService.saveToken(token: token);
        log("Auth token is ; ${AuthService.token}");

        log('Verify token received: $token');

        AppSnackBar.showSuccess(
          responseBody['message'] ?? "OTP sent to your email!",
        );

        Get.toNamed(
          AppRoute.otpVerificationScreen,
          arguments: {
            'email': email.toLowerCase().trim(),
            'reason': OTPReason.forgetPassword,
            'token': token,
          },
        );
      } else if (response.statusCode == 404) {
        AppSnackBar.showError("User not found!");
      } else {
        AppSnackBar.showError(response.errorMessage);
        log('Error: ${response.errorMessage}');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError(e.toString());
      log('Exception in sendForgotPasswordOTP: $e');
    }
  }

  // @override
  // void onClose() {
  //   emailPhoneController.dispose();
  //   super.onClose();
  // }
}
