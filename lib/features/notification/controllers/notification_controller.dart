import 'dart:developer';

import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import '../models/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserNotification();
  }

  final isNotificationLoading = false.obs;
  //for get user notification
  Future<void> getUserNotification() async {
    try {
      isNotificationLoading(true);
      final response = await NetworkCaller().getRequest(
        AppUrls.getUserNotification,
      );
      if (response.isSuccess) {
        log("Notification get successful");
        final data = GetAllNotificationModel.fromJson(response.responseData);
        notifications.value = data.result ?? [];
      } else {
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    } finally {
      isNotificationLoading(false);
    }
  }
}
