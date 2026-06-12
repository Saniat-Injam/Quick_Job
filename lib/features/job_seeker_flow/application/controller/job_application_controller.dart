import 'dart:developer';

import 'package:get/get.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/features/job_seeker_flow/application/models/job_application_model.dart';
import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/auth_service.dart';

class JobApplicationController extends GetxController {
  var selectedFilter = 'All'.obs;
  var applications = <JobApplicationModel>[].obs;
  var isLoading = false.obs;
  var currentPage = 1.obs;
  final int pageSize = 10;
  var hasMoreData = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApplications();
  }

  RxList<JobApplicationModel> get filteredApplications => applications
      .where((app) {
        if (selectedFilter.value == 'All') {
          return true;
        }
        return app.status.toUpperCase() == selectedFilter.value.toUpperCase();
      })
      .toList()
      .obs;

  // String _buildQueryString(Map<String, dynamic> params) {
  //   return params.entries
  //       .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
  //       .join('&');
  // }

  Future<void> fetchApplications({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        applications.clear();
        hasMoreData.value = true;
      }

      if (!hasMoreData.value || isLoading.value) return;

      isLoading.value = true;

      Map<String, String> queryParams = {
        'page': currentPage.value.toString(),
        'limit': pageSize.toString(),
      };

      if (selectedFilter.value.isNotEmpty && selectedFilter.value != 'All') {
        queryParams['status'] = selectedFilter.value.toUpperCase();
      }

      final queryString = Uri(queryParameters: queryParams).query;
      log("Fetching applications with params: $queryString");

      final response = await NetworkCaller().getRequest(
        AppUrls.getJobSekerAplyedJob(status: queryParams),
        token: "Bearer ${AuthService.token}",
      );

      if (response.statusCode == 200) {
        final data = response.responseData;
        log("Data fetched: $data");

        if (data['success'] == true) {
          final jobsList = data['result']['data'] ?? [];
          List<JobApplicationModel> newApplications = jobsList
              .map<JobApplicationModel>((jobData) {
                return JobApplicationModel.fromJson(jobData);
              })
              .toList();

          if (isRefresh || currentPage.value == 1) {
            applications.assignAll(newApplications);
          } else {
            applications.addAll(newApplications);
          }

          hasMoreData.value = newApplications.length == pageSize;
          currentPage.value++;
          log("Applications fetched successfully: ${applications.length}");
          // AppSnackBar.showSuccess("Applications loaded successfully");
        } else if (response.statusCode == 403) {
          await AuthService.logoutUser();
          AppSnackBar.showError(
            "You are not authorized please login to continue",
          );
        } else {
          AppSnackBar.showError(
            data['message'] ?? "Failed to fetch applications",
          );
        }
      } else {
        // AppSnackBar.showError("Server error: ${response?.statusCode}");
        // log('Error: ${response?.statusCode} - ${response?.responseData}');
      }
    } catch (e) {
      log(
        "Error fetching applications: $e",
        error: e,
        stackTrace: StackTrace.current,
      );
      AppSnackBar.showError("Error fetching applications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter.toUpperCase();
    // applications.clear();
    currentPage.value = 1;
    hasMoreData.value = true;
    fetchApplications(isRefresh: true);
  }
}
