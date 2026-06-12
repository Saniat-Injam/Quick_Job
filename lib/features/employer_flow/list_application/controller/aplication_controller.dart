import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'dart:convert';
import '../../../../core/services/auth_service.dart';

class AplicationController extends GetxController {
  final seletedStatus = 'INTERVIEW'.obs;
  final messageController = TextEditingController();
  final pickaDate = TextEditingController();
  final isSubmitting = false.obs;

  final statusList = ['INTERVIEW', 'REJECT'].obs;

  // Replace with your actual base URL
  final String baseUrl = AppUrls.updateJObStatus;

  void troggleStatus(String? newValue) {
    seletedStatus.value = newValue ?? '';
  }

  Future<bool> submitApplicationStatus({
    required String jobApplyId,
    required String status,
    required String message,
    String? interviewDate,
    String? interviewTime,
  }) async {
    isSubmitting.value = true;
    try {
      log("I am hear");
      final url = Uri.parse('${AppUrls.updateJObStatus}$jobApplyId');

      // Prepare request body based on status
      Map<String, dynamic> requestBody;

      if (status == 'ACCEPT') {
        String formattedDate = interviewDate!;
        if (!formattedDate.contains('T')) {
          formattedDate = '${formattedDate}T00:00:00.000+00:00';
        }

        requestBody = {
          "status": "ACCEPT",
          "InterViewTime": interviewTime ?? "",
          "InterviewDate": formattedDate,
          "message": message.isEmpty
              ? "Congratulations! You are accepted for interview."
              : message,
        };
      } else {
        // REJECT status
        requestBody = {
          "status": "REJECT",
          "message": message.isEmpty
              ? "Sorry, we cannot proceed with your application at this time."
              : message,
        };
      }

      print('API URL: $url');
      print('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token.toString()}',
        },

        body: jsonEncode(requestBody),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return true;
      } else {
        // Handle error
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Submission error: $e');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> submitApplicationStatusAndNavigate({
    required String jobApplyId,
    required String selectedStatus,
    String? interviewTime,
    required Widget interviewScreen,
    required Widget rejectionScreen,
  }) async {
    if (selectedStatus.isEmpty) {
      AppSnackBar.showError("Please select a status");
      return;
    }

    final statusApi = selectedStatus == 'Interview' ? 'ACCEPT' : 'REJECT';

    if (selectedStatus == 'Interview') {
      if (pickaDate.text.isEmpty) {
        AppSnackBar.showError("Please select an interview date");
        return;
      }
      if (interviewTime == null || interviewTime.isEmpty) {
        AppSnackBar.showError("Please enter an interview time");
        return;
      }
    }

    // Submit the application status
    final success = await submitApplicationStatus(
      jobApplyId: jobApplyId,
      status: statusApi,
      message: messageController.text,
      interviewDate: selectedStatus == 'Interview' ? pickaDate.text : null,
      interviewTime: selectedStatus == 'Interview' ? interviewTime : null,
    );

    if (success) {
      if (selectedStatus == 'INTERVIEW') {
        Get.off(() => interviewScreen);
      } else if (selectedStatus == 'REJECT') {
        Get.off(() => rejectionScreen);
      } else {
        Get.back();
      }
    } else {
      AppSnackBar.showError("Failed to update application status");
    }
  }

  @override
  void onClose() {
    // messageController.dispose();
    // pickaDate.dispose();
    super.onClose();
  }
}
