import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/features/chat/models/conversation_list_model.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';

class ChatController extends GetxController {
  // for pagination
  final scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    getConversationList(isRefresh: true);
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
        getConversationList();
      }
    }
  }

  final isUserLoading = false.obs;
  final isLoadMore = false.obs;
  int totalPage = 1;
  int currantPage = 1;
  int limit = 10;
  bool hasMore = true;
  final conversationListData = <Conversation>[].obs;
  // for get all user data
  Future<void> getConversationList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currantPage = 1;
        hasMore = true;
        conversationListData.clear();
      }
      if (!hasMore) return;
      if (currantPage == 1) {
        isUserLoading(true);
      } else {
        isLoadMore(true);
      }

      final response = await NetworkCaller().getRequest(
        "${AppUrls.getConversationList}?limit=$limit&page=$currantPage",
        // token: AuthService.token.toString(),
      );
      if (response.isSuccess) {
        log("post fetch successful! for $currantPage");
        final data = GetConversationListModel.fromJson(response.responseData);
        if (data.result != null && (data.result ?? []).isNotEmpty) {
          conversationListData.addAll(data.result ?? []);
          currantPage = data.meta?.page ?? 0;
          totalPage = data.meta?.total ?? 0;
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
