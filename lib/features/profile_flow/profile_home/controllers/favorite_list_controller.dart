import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/profile_flow/profile_home/models/get_favorite_user_list_model.dart';

class FavoriteListController extends GetxController {
  // for pagination
  final scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    getFavoriteUserList(isRefresh: true);
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // for load more data
  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      log("isMoreLoading: ${isLoadMore.value}, hasMore: $hasMore");
      if (!isLoadMore.value && hasMore) {
        getFavoriteUserList();
      }
    }
  }

  final isUserLoading = false.obs;
  final isLoadMore = false.obs;
  int totalPage = 1;
  int currantPage = 1;
  int limit = 20;
  bool hasMore = true;
  final likedUserData = <LikedUserList>[].obs;
  // for get user all post
  Future<void> getFavoriteUserList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currantPage = 1;
        hasMore = true;
        likedUserData.clear();
      }
      if (!hasMore) return;
      if (currantPage == 1) {
        isUserLoading(true);
      } else {
        isLoadMore(true);
      }

      final response = await NetworkCaller().getRequest(
        "${AppUrls.getLikedUserList}?limit=$limit&page=$currantPage",
        // token: AuthService.token.toString(),
      );
      if (response.isSuccess) {
        log("post fetch successful! for $currantPage");
        final data = GetFavoriteUserListModel.fromJson(response.responseData);
        if (data.result?.data != null && (data.result?.data ?? []).isNotEmpty) {
          likedUserData.addAll(data.result?.data ?? []);
          currantPage = data.result?.meta?.page ?? 0;
          totalPage = data.result?.meta?.totalPages ?? 0;
          log("Current page is : $currantPage total page is : $totalPage");

          if (currantPage >= totalPage) {
            hasMore = false;
          } else {
            currantPage++;
            hasMore = true;
          }
        } else {
          hasMore = false;
        }
      } else {
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppLoggerHelper.error("Api Error : $e");
    } finally {
      isUserLoading(false);
      isLoadMore(false);
    }
  }
}
