import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/features/employer_flow/home/models/recently_applied_candidates_model.dart';

class RecentlyAppliedCandidatesController extends GetxController {
  final searchController = TextEditingController();
  final locationController = TextEditingController();

  final NetworkCaller _networkCaller = NetworkCaller();

  /// UI STATE
  final RxBool isLoadingApplied = false.obs;
  final RxList<ApliedData> recentApplied = <ApliedData>[].obs;

  /// PAGINATION
  final ScrollController scrollController = ScrollController();
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  /// HOME → SHOW ONLY 3
  // List<ApliedData> get homePreviewList =>
  //     recentApplied.length > 3 ? recentApplied.take(3).toList() : recentApplied;

  @override
  void onInit() {
    super.onInit();
    fetchRecentlyApplied();
    _setupScrollListener();
  }

  /// API CALL
  Future<void> fetchRecentlyApplied({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (_isFetchingMore || !_hasMore) return;
      _isFetchingMore = true;
    } else {
      isLoadingApplied.value = true;
      _page = 1;
      _hasMore = true;
      recentApplied.clear();
    }

    Map<String, dynamic> queryParams = {'page': _page.toString()};

    if (searchController.text.isNotEmpty) {
      queryParams['searchQuery'] = searchController.text;
    }
    if (languageValue.value.isNotEmpty) {
      queryParams['language'] = languageValue.value.toUpperCase();
    }
    if (locationController.text.isNotEmpty) {
      queryParams['location'] = locationController.text;
    }
    if (onlineStatusValue.value.isNotEmpty) {
      queryParams['onlineStatus'] = onlineStatusValue.value == "Online" ? 1 : 0;
    }
    queryParams['minAge'] = minAge.value;
    queryParams['maxAge'] = maxAge.value;

    final url =
        '${AppUrls.recentlyAppliedCandidates}?${_buildQueryString(queryParams)}';

    final response = await _networkCaller.getRequest(url);

    if (response.isSuccess && response.responseData != null) {
      try {
        final data = RecentlyAppliedCandidatesModel.fromJson(
          response.responseData,
        );

        final newItems = data.result?.data ?? [];

        if (newItems.isNotEmpty) {
          recentApplied.addAll(newItems);
          _page++;
        } else {
          _hasMore = false;
        }
      } catch (e) {
        log('Parsing error: $e');
      }
    }

    isLoadingApplied.value = false;
    _isFetchingMore = false;
  }

  String _buildQueryString(Map<String, dynamic> params) {
    return params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }

  /// API CALL
  Future<void> refreshFunction() async {
    minAge.value = 1;
    maxAge.value = 50;
    onlineStatusValue.value = "";
    languageValue.value = "";
    searchController.text = "";
    locationController.text = "";
    final url = '${AppUrls.recentlyAppliedCandidates}?page=1&limit=$_limit';

    final response = await _networkCaller.getRequest(url);

    if (response.isSuccess && response.responseData != null) {
      try {
        final data = RecentlyAppliedCandidatesModel.fromJson(
          response.responseData,
        );

        final newItems = data.result?.data ?? [];

        if (newItems.isNotEmpty) {
          recentApplied.value = [];
          recentApplied.addAll(newItems);
        }
      } catch (e) {
        log('Parsing error: $e');
      }
    }

    isLoadingApplied.value = false;
    _isFetchingMore = false;
  }

  /// SCROLL PAGINATION (SEE ALL)
  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        fetchRecentlyApplied(isLoadMore: true);
      }
    });
  }

  /// PULL TO REFRESH
  Future<void> refreshAppliedCandidates() async {
    _page = 1;
    _hasMore = true;
    recentApplied.clear();
    await refreshFunction();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // // for call a user
  // Future<void> makePhoneCall({required String phoneNumber}) async {
  //   final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

  //   if (await canLaunchUrl(phoneUri)) {
  //     await launchUrl(phoneUri);
  //   } else {
  //     throw 'Could not launch dialer';
  //   }
  // }

  RxInt minAge = 1.obs;
  RxInt maxAge = 50.obs;

  final languageList = ["English", "Spanish"].obs;
  final languageValue = "".obs;
  void changeLanguageValue(String value) {
    languageValue.value = value;
  }

  // final nationalityList = ["Bangladesh", "USA", "Canada"].obs;
  // final nationalityValue = "USA".obs;
  // void changeNationalityValue(String value) {
  //   nationalityValue.value = value;
  // }

  final onlineStatusList = ["Online", "Offline"].obs;
  final onlineStatusValue = "".obs;
  void changeOnlineStatusValue(String value) {
    onlineStatusValue.value = value;
  }
}
