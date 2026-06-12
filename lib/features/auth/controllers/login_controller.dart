import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/routes/app_routes.dart';
import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class LoginController extends GetxController {
  final String role;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  LoginController({required this.role});

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    loadingProgressIndicator(title: 'Logging in...');
    isLoading.value = true;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log("Token is  $fcmToken");

    try {
      final requestBody = {
        "email": emailController.text.trim().toLowerCase(),
        "password": passwordController.text.trim(),
        "fcmToken": fcmToken ?? "",
      };

      final response = await NetworkCaller().postRequest(
        AppUrls.logIn,
        body: requestBody,
      );

      Get.back(); // ✅ CLOSE LOADER ALWAYS

      if (response.isSuccess) {
        final data = response.responseData?['result'];

        final String? token = data?['accessToken'];
        final String? role = data?['role'];
        final String? userId = data?['id']; // ✅ IMPORTANT
        log("user id form server : $userId");

        AppLoggerHelper.debug("Role is : ${role}");

        if (token == null || token.isEmpty) {
          AppSnackBar.showError('Login failed: token missing');
          return;
        }

        // ✅ SAVE EVERYTHING
        await AuthService.saveToken(token: token);
        if (userId != null) {
          await AuthService.saveId(id: userId);
        }
        if (role != null) {
          await AuthService.saveRole(role: role);
        }

        navigateBasedOnRole(role ?? '');
      } else if (response.statusCode == 401) {
        AppSnackBar.showError("Invalid email or password");
      } else {
        AppSnackBar.showError("Invalid email or password");
      }
    } catch (e, s) {
      Get.back();
      log("Login error", error: e, stackTrace: s);
      AppSnackBar.showError('Login failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateBasedOnRole(String role) {
    Get.offAllNamed(AppRoute.bottomNavbar, arguments: {'role': role});
  }
}
