import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';

class EditJobPostDetailController extends GetxController {
  // Text Controllers
  final namePositionController = TextEditingController();
  final salaryController = TextEditingController();
  final locationController = TextEditingController();
  final jobTypeController = TextEditingController();
  final jobCategoryController = TextEditingController();

  // Reactive variables
  var selectedTab = 0.obs;
  var seletedType = ''.obs;
  var seletedWorkType = ''.obs;
  var allRequerdMent = <String>[].obs;

  // Dropdown lists
  final jobTypeList = ['ON_SITE', 'HYBRID', 'REMOTE'];

  final workTypeList = ['HYBRID', 'REMOTE', "ON_SITE"];

  var isLoading = false.obs;
  var jobId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with default values
    if (seletedType.isEmpty) {
      seletedType.value = jobTypeList.first;
    }
    if (seletedWorkType.isEmpty) {
      seletedWorkType.value = workTypeList.first;
    }
  }

  // Change tab
  void changeTab(int tabIndex) {
    selectedTab.value = tabIndex;
  }

  // Toggle job type
  void seletedTroggleType(String? value) {
    if (value != null) {
      seletedType.value = value;
    }
  }

  // Toggle work type
  void seletedTroggleTypeWork(String? value) {
    if (value != null) {
      seletedWorkType.value = value;
    }
  }

  // Add requirement
  void addData() {
    final requirement = jobTypeController.text.trim();
    if (requirement.isNotEmpty) {
      allRequerdMent.add(requirement);
      jobTypeController.clear();
      Get.back();
      log('Requirement added: $requirement');
    } else {
      AppSnackBar.showError('Please enter a requirement');
    }
  }

  void removeRequirement(int index) {
    if (index >= 0 && index < allRequerdMent.length) {
      allRequerdMent.removeAt(index);
      log('Requirement removed at index: $index');
    }
  }

  // Clear all requirements
  void clearAllRequirements() {
    allRequerdMent.clear();
  }

  // Update vacancy on server
  Future<void> updateVacancy(String jobPostId) async {
    try {
      isLoading.value = true;

      String? token = AuthService.token;
      if (token == null || token.isEmpty) {
        AppSnackBar.showError('Authentication token not found');
        return;
      }

      final requestBody = {
        //'jobPostStatus' : 'ACTIVE',
        'position': namePositionController.text.trim(),
        'salary': int.tryParse(salaryController.text.trim()) ?? 0,
        'location': locationController.text.trim(),
        'jobType': seletedType.value,
        // 'workArrangement': seletedWorkType.value,
        'requirements': allRequerdMent.toList(),
      };

      final url = AppUrls.updateJobPost(jobPostId: jobPostId);
      debugPrint('Final URL: $url');
      log('=== Updating Job Post ===');
      log('URL: $url');
      log('Body: $requestBody');
      log('Using Bearer token: ${AuthService.token}');

      final response = await NetworkCaller().patchRequest(
        AppUrls.updateJobPost(jobPostId: jobPostId),
        body: requestBody,
        // token: "Bearer ${AuthService.token.toString()}",
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.responseData}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        AppSnackBar.showSuccess('Job updated successfully');

        // final responseBody = response.responseData;

        // if (response.isSuccess) {
        //   AppSnackBar.showSuccess('Job updated successfully');
        //   Get.back();
        // } else {
        //   log('Error updating job: ${response.responseData}');
        //   AppSnackBar.showError(
        //     responseBody['message'] ?? 'Failed to update job',
        //   );
        // }
      } else {
        log('Error updating job: ${response.responseData}');
        AppSnackBar.showError('Failed to update job post');
      }
    } catch (e) {
      AppSnackBar.showError("An error occurred: $e");
      log("Error updating job: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Populate fields from job data
  void populateFieldsFromJobData(Map<String, dynamic> jobData) {
    try {
      namePositionController.text = jobData['position'] ?? '';
      salaryController.text = (jobData['salary'] ?? '').toString();
      locationController.text = jobData['location'] ?? '';

      if (jobData['jobType'] != null &&
          jobTypeList.contains(jobData['jobType'])) {
        seletedType.value = jobData['jobType'];
      }

      if (jobData['workArrangement'] != null &&
          workTypeList.contains(jobData['workArrangement'])) {
        seletedWorkType.value = jobData['workArrangement'];
      }

      List<String> requirements = List<String>.from(
        jobData['requirements'] ?? [],
      );
      allRequerdMent.assignAll(requirements);

      jobId.value = jobData['id'] ?? '';

      log('Fields populated from job data');
    } catch (e) {
      log('Error populating fields: $e');
      AppSnackBar.showError('Error loading job data');
    }
  }

  // Validate form
  bool validateForm() {
    if (namePositionController.text.trim().isEmpty) {
      AppSnackBar.showError('Please enter position name');
      return false;
    }
    if (salaryController.text.trim().isEmpty) {
      AppSnackBar.showError('Please enter salary');
      return false;
    }
    if (int.tryParse(salaryController.text.trim()) == null) {
      AppSnackBar.showError('Please enter a valid salary');
      return false;
    }
    if (locationController.text.trim().isEmpty) {
      AppSnackBar.showError('Please enter location');
      return false;
    }
    if (seletedType.value.isEmpty) {
      AppSnackBar.showError('Please select job type');
      return false;
    }
    if (seletedWorkType.value.isEmpty) {
      AppSnackBar.showError('Please select work arrangement');
      return false;
    }
    if (allRequerdMent.isEmpty) {
      AppSnackBar.showError('Please add at least one requirement');
      return false;
    }
    return true;
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   namePositionController.dispose();
  //   salaryController.dispose();
  //   locationController.dispose();
  //   jobTypeController.dispose();
  // }
}
