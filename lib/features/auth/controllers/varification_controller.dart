import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/features/auth/models/varification_model.dart';
import 'package:quick_job/features/auth/views/screens/create_password_screen.dart';
import 'package:quick_job/routes/app_routes.dart';
import '../../../core/common/widgets/app_snack_bar.dart';

/// OTP Reason Types
class OTPReason {
  static const String signupOtp = "SIGNUP_OTP_SECRET";
  static const String loginOtp = "LOGIN_OTP_SECRET";
  static const String resetPassword = "RESET_PASSWORD_SECRET";
  static const String forgetPassword = "FORGET_PASSWORD_SECRET";

  /// Get user-friendly message for each reason
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

class VerificationController extends GetxController {
  final VerificationModel model;
  VerificationController(this.model);
  String otpCode = '';
  String? fcmToken;
  String? email;
  String? verifyToken; // Temporary token from previous step
  late final String _currentReason;
  String get currentReason => _currentReason;
  var remainingSeconds = 60.obs;
  Timer? _timer;
  final otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments?['email'] ?? '';
    final passedReason = Get.arguments?['reason'] ?? OTPReason.signupOtp;
    fcmToken = Get.arguments?['fcmToken'] ?? '';

    // Set verifyToken to null if not present (Best practice for nullable fields)
    verifyToken = Get.arguments?['token'];

    _currentReason = OTPReason.isValid(passedReason)
        ? passedReason!
        : OTPReason.signupOtp;

    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    remainingSeconds.value = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> resendCode() async {
    if (email == null || email!.isEmpty) {
      AppSnackBar.showError("Email not found. Please try again.");
      return;
    }

    if (remainingSeconds.value > 0) {
      AppSnackBar.showError(
        "Please wait ${remainingSeconds.value} seconds before resending",
      );
      return;
    }

    final requestBody = {
      "email": email!.toLowerCase(),
      "reason": _currentReason,
    };

    await resendOTPRequest(requestBody);
  }

  Future<void> resendOTPRequest(Map<String, dynamic> requestBody) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await NetworkCaller().postRequest(
        AppUrls.resendOtp,
        body: requestBody,
      );

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.isSuccess) {
        startTimer();
        // AppSnackBar.showSuccess(
        //   "OTP resent to your email for ${OTPReason.getMessage(_currentReason)}!",
        // );
        log('OTP resent successfully for reason: $_currentReason');
      } else {
        // AppSnackBar.showError(response.errorMessage);
        log('Resend OTP failed: ${response.errorMessage}');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      // AppSnackBar.showError(e.toString());
      log('Resend OTP Exception: $e');
    }
  }

  Future<void> verifyOTP(Map<String, dynamic> requestBody) async {
    log("Starting OTP verification for reason: $_currentReason");
    log("Verify OTP Request Body: $requestBody");
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      log("Permanent Auth Token (AuthService.token): ${AuthService.token}");
      log("Temporary Verification Token (verifyToken): $verifyToken");

      final response = await NetworkCaller().postRequest(
        AppUrls.verifyOtp,
        body: requestBody,
        token: "Bearer ${AuthService.token.toString()}",
      );

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.isSuccess) {
        final responseBody = response.responseData;
        final token = responseBody['result']?['token'];
        final isProfile = responseBody['result']?['isProfile'] ?? false;

        if (token != null && token.isNotEmpty) {
          await AuthService.saveToken(token: token);
          log('New reset token saved after successful OTP verification');
        }

        AppSnackBar.showSuccess(
          responseBody['message'] ?? "OTP verified successfully",
        );

        _handleNavigationAfterVerification(isProfile);
      } else if (response.statusCode == 401) {
        AppSnackBar.showError("Otp expired");
      } else if (response.statusCode == 404) {
        AppSnackBar.showError("Wrong Otp");
      } else {
        AppSnackBar.showError(response.errorMessage);
        log('Error: ${response.errorMessage}');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError(e.toString());
      log('Exception: $e');
    }
  }

  // ... rest of the file ...

  void _handleNavigationAfterVerification(bool isProfile) {
    switch (_currentReason) {
      case OTPReason.forgetPassword:
      case OTPReason.resetPassword:
        // Get.offAllNamed(
        //   AppRoute.resetPasswordScreen,
        //   arguments: {'email': email},
        // );
        Get.offAll(() => CreatePasswordScreen());
        break;

      case OTPReason.loginOtp:
        Get.offAllNamed(AppRoute.homeScreen);
        break;

      case OTPReason.signupOtp:
        if (isProfile) {
          Get.offAllNamed(AppRoute.homeScreen);
        } else {
          Get.offAllNamed(AppRoute.loginScreen);
        }
        break;

      default:
        if (isProfile) {
          Get.offAllNamed(AppRoute.homeScreen);
        } else {
          Get.offAllNamed(AppRoute.loginScreen);
        }
        break;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
