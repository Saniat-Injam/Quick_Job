import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';

class EmployerController extends GetxController {
  final searchController = TextEditingController();
  var filteredJobList = <Map<String, dynamic>>[].obs;
  var allJobs = <Map<String, dynamic>>[].obs;
  var resumeId = RxString('');

  var selectedCategory = 'All Vacancies'.obs;

  var isLoading = false.obs;
  var isPaginationLoading = false.obs;
  final scrollController = ScrollController();

  var currentPage = 1.obs;
  final perPageLimit = 10;
  var totalItems = 0.obs;
  var totalPages = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobPosts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        if (currentPage.value < totalPages.value &&
            !isPaginationLoading.value) {
          loadMoreJobs();
        }
      }
    });
  }

  Future<void> fetchJobPosts({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      }

      String? token = AuthService.token;
      if (token == null || token.isEmpty) {
        AppSnackBar.showError('Authentication token not found');
        return;
      }

      String statusQuery = _getStatusFromCategory();

      String apiUrl =
          '${AppUrls.getEmployerJobPost}?page=$page&limit=$perPageLimit';
      if (statusQuery.isNotEmpty) {
        apiUrl += '&status=$statusQuery';
      }

      print('=== Fetching Job Posts ===');
      print('URL: $apiUrl');
      print('Token: Bearer $token');

      final response = await NetworkCaller().getRequest(
        apiUrl,
        token: "Bearer $token",
      );

      if (response.statusCode == 200) {
        final responseBody = response.responseData;

        if (responseBody['success'] == true) {
          final result = responseBody['result'] as Map<String, dynamic>? ?? {};
          final meta = result['meta'] as Map<String, dynamic>? ?? {};
          final data = result['data'] as List? ?? [];
          totalItems.value = meta['total'] as int? ?? 0;
          totalPages.value = meta['totalPages'] as int? ?? 1;
          currentPage.value = page;

          List<Map<String, dynamic>> jobs = [];
          for (var job in data) {
            final jobMap = job as Map<String, dynamic>;
            jobs.add({
              'id': jobMap['_id'] ?? jobMap['id'] ?? '',
              'position': jobMap['position'] ?? 'Unknown',
              'salary': jobMap['salary'] ?? 0,
              'location': jobMap['location'] ?? '',
              'jobType': jobMap['jobType'] ?? '',
              'jobCategory': jobMap['JobCategory'] ?? '',
              'requirements': List<String>.from(jobMap['requirements'] ?? []),
              'jobPostStatus': jobMap['jobPostStatus'] ?? 'ACTIVE',
              'status': jobMap['jobPostStatus'] == 'ACTIVE'
                  ? 'Active'
                  : 'Inactive',
              'companyName':
                  (jobMap['employeer_profile'] as Map<String, dynamic>? ??
                      {})['companyName'] ??
                  'Company',
            });
          }

          if (page == 1) {
            allJobs.assignAll(jobs);
            filteredJobList.assignAll(jobs);
          } else {
            allJobs.addAll(jobs);
            filteredJobList.addAll(jobs);
          }

          print('Jobs loaded: ${jobs.length}, Total: ${totalItems.value}');
        } else {
          AppSnackBar.showError('Failed to fetch job posts');
        }
      } else {
        AppSnackBar.showError('Failed to fetch job posts');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      AppSnackBar.showError('Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
    }
  }

  // Load more jobs (pagination)
  Future<void> loadMoreJobs() async {
    if (isPaginationLoading.value) return;

    isPaginationLoading.value = true;
    int nextPage = currentPage.value + 1;

    await fetchJobPosts(page: nextPage);
  }

  String _getStatusFromCategory() {
    switch (selectedCategory.value) {
      case 'Active':
        return 'ACTIVE';
      case 'Inactive':
        return 'INACTIVE';
      case 'Pause':
        return 'PAUSE';
      default:
        return '';
    }
  }

  // Toggle category selection and reload data
  void toggleSelection(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = 'All Vacancies';
    } else {
      selectedCategory.value = category;
    }

    currentPage.value = 1;
    fetchJobPosts();
  }

  void searchJobs(String query) {
    if (query.isEmpty) {
      filterByCategory();
    } else {
      filteredJobList.assignAll(
        allJobs
            .where(
              (job) =>
                  job['position'].toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  job['companyName'].toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  job['location'].toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList(),
      );
    }
  }

  // Filter by selected category
  void filterByCategory() {
    if (selectedCategory.value == 'All Vacancies' ||
        selectedCategory.value.isEmpty) {
      filteredJobList.assignAll(
        allJobs,
      ); // Show all jobs (both active and inactive)
    } else {
      filteredJobList.assignAll(
        allJobs
            .where((job) => job['status'] == selectedCategory.value)
            .toList(),
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    scrollController.dispose();
  }

  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////
  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////
  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////
  ///////////////////////////////////////// js jedny clean code ///////////////////////////////////////

  final ageValue = 18.0.obs;
  void changeAgeValue(double value) {
    ageValue.value = value;
  }

  final languageList = ["English", "Bangla"].obs;
  final languageValue = "English".obs;
  void changeLanguageValue(String value) {
    languageValue.value = value;
  }

  final nationalityList = ["Bangladesh", "USA", "Canada"].obs;
  final nationalityValue = "USA".obs;
  void changeNationalityValue(String value) {
    nationalityValue.value = value;
  }

  final onlineStatusList = ["Online", "Offline"].obs;
  final onlineStatusValue = "Online".obs;
  void changeOnlineStatusValue(String value) {
    onlineStatusValue.value = value;
  }
}

extension HomePreview on EmployerController {
  /// Home screen shows only 3 posts
  List<Map<String, dynamic>> get homeJobPreview =>
      filteredJobList.take(3).toList();

  /// Pull-to-refresh
  Future<void> refreshJobs() async {
    currentPage.value = 1;
    await fetchJobPosts(page: 1);
  }

  // delete job
  Future<void> deleteJobPost({required String id}) async {
    try {
      if (id.isEmpty) {
        AppSnackBar.showError("Job not found try again later");
        return;
      }
      loadingProgressIndicator();
      final response = await NetworkCaller().deleteRequest(
        AppUrls.deleteAJobPost(jobPostId: id),
        "Bearer ${AuthService.token.toString()}",
      );
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (response.isSuccess) {
        await refreshJobs();
        AppSnackBar.showSuccess("Job post delete successful");
      } else {
        AppSnackBar.showError("Api Error : ${response.errorMessage}");
        AppLoggerHelper.error("Api Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    }
  }
}
