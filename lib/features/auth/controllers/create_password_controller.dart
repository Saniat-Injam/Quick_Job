import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class CreatePasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  var isLoading = false.obs;

  String reason = '';

  @override
  void onInit() {
    super.onInit();
    reason = Get.arguments?['reason'] ?? 'RESET_PASSWORD_SECRET';
  }

  void submitPassword() async {
    try {
      // final oldPassword = oldPasswordController.text.trim();
      final newPassword = newPasswordController.text.trim();

      if (newPassword.isEmpty) {
        // Get.snackbar('Error', 'Please enter a new password');
        AppSnackBar.showError("Please enter a new password");
        return;
      }
      loadingProgressIndicator();

      // isLoading.value = true;
      final requestBody = {"newPassword": newPassword, "reason": reason};

      final response = await NetworkCaller().postRequest(
        AppUrls.resetPassword,
        body: requestBody,
      );
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.isSuccess) {
        AppSnackBar.showSuccess('Password updated successfully');
        AuthService.logoutUser();
      } else {
        AppSnackBar.showError('Something went wrong');
      }
    } catch (e) {
      // Get.snackbar('Error', 'Something went wrong');
      AppSnackBar.showError('Something went wrong');
      print("Password reset error: $e");
    }
  }

  void resetPassword() async {
    try {
      final newPassword = newPasswordController.text.trim();

      if (newPassword.isEmpty) {
        // Get.snackbar('Error', 'Please enter a new password');
        AppSnackBar.showError("Please enter a new password");
        return;
      }
      loadingProgressIndicator();

      // isLoading.value = true;
      final requestBody = {"newPassword": newPassword, "reason": reason};

      final response = await NetworkCaller().patchRequest(
        AppUrls.resetNewPassword,
        body: requestBody,
      );
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.isSuccess) {
        AppSnackBar.showSuccess('Password updated successfully');
        AuthService.logoutUser();
      } else {
        AppSnackBar.showError('Something went wrong');
      }
    } catch (e) {
      // Get.snackbar('Error', 'Something went wrong');
      AppSnackBar.showError('Something went wrong');
      print("Password reset error: $e");
    }
  }

  // @override
  // void onClose() {
  //   newPasswordController.dispose();
  //   oldPasswordController.dispose();
  //   super.onClose();
  // }
}
