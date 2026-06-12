import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

class AplicationDetailController extends GetxController {
  var jobDetails = <String, dynamic>{}.obs;
  var applicants = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isLoadingApplicants = false.obs;

  Future<void> fetchJobDetails(String jobPostId) async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        AppUrls.getSingleJobPost(jobPostId: jobPostId),
        token: "Bearer ${AuthService.token}",
      );

      if (response.statusCode == 200 && response.responseData != null) {
        final responseData = _parseResponse(response.responseData);
        final result = responseData['result'];

        if (result is Map<String, dynamic>) {
          jobDetails.value = Map<String, dynamic>.from(result);
        } else {
          debugPrint("API response 'result' is not a Map: $result");
          Get.snackbar('Error', 'Invalid data format for job details.');
        }
      } else {
        debugPrint("Error: ${response.statusCode}");
        Get.snackbar(
          'Error',
          'Failed to load job details. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Error fetching job details: $e");
      Get.snackbar(
        'Error',
        'An error occurred fetching job details: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchApplicants(String jobPostId) async {
    try {
      isLoadingApplicants.value = true;

      final response = await NetworkCaller().getRequest(
        AppUrls.getSingleJobPost(jobPostId: jobPostId),
        token: "Bearer ${AuthService.token}",
      );

      if (response.statusCode == 200 && response.responseData != null) {
        final responseData = _parseResponse(response.responseData);
        final result = responseData['result'];

        if (result is Map && result.containsKey('JobApply')) {
          final jobApplyList = result['JobApply'] as List<dynamic>;

          applicants.value = jobApplyList.map<Map<String, dynamic>>((item) {
            if (item is! Map<String, dynamic>) return {};

            final profile =
                item['job_seekers_profile'] as Map<String, dynamic>? ?? {};
            final user = profile['user'] as Map<String, dynamic>? ?? {};
            final resumes =
                profile['job_seekers_resume'] as List<dynamic>? ?? [];

            String resumeUrl = '';
            if (resumes.isNotEmpty && resumes[0] is Map<String, dynamic>) {
              resumeUrl =
                  (resumes[0] as Map<String, dynamic>)['resumeUrl']
                      as String? ??
                  '';
            }

            AppLoggerHelper.error("resume url is : $resumeUrl");

            return {
              'id': item['id'] as String? ?? '',
              'fullName': user['fullName'] as String? ?? 'Candidate Name',
              'position': profile['occupation'] as String? ?? 'Position',
              'profileImage': user['profileImage'] as String? ?? '',
              'resumeUrl': resumeUrl,
              'address': profile['address'] as String? ?? '',
              'education': profile['education'] as String? ?? '',
              'experience': profile['jobExperince'] as String? ?? '',
              'gender': profile['gender'] as String? ?? '',
              'age': profile['age'] is num ? profile['age'] as num : 0,
              'description': profile['desc'] as String? ?? '',
              'jobSeekerId': item['job_seekers_id'] as String? ?? '',
              'languageProfessional':
                  profile['languageProfessional'] as String? ?? '',
              'languageNative': profile['languageNative'] as String? ?? '',
            };
          }).toList();
        } else {
          applicants.value = [];
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch applicants. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Error fetching applicants: $e");
      Get.snackbar(
        'Error',
        'An error occurred while fetching applicants: ${e.toString()}',
      );
    } finally {
      isLoadingApplicants.value = false;
    }
  }

  dynamic _parseResponse(dynamic responseData) {
    if (responseData is String) {
      return jsonDecode(responseData);
    } else if (responseData is Map) {
      return responseData;
    } else {
      throw Exception(
        'Unexpected response data type: ${responseData.runtimeType}',
      );
    }
  }
}
