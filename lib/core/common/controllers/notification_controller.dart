import 'package:get/get.dart';
import 'package:quick_job/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController extends GetxController {
  RxBool isNotifyOn = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotificationState();
  }

  Future<void> loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool("notifications_enabled") ?? true;
    isNotifyOn.value = value;
  }

  void toggleNotifications(bool value) async {
    isNotifyOn.value = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifications_enabled", value);

    if (value) {
      await enableNotifications();
    } else {
      await disableNotifications();
    }

    // send to backend
    NotificationService.updateNotificationStatus(value);
  }

  Future<void> enableNotifications() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    await FirebaseMessaging.instance.subscribeToTopic("general_notifications");
  }

  Future<void> disableNotifications() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(
      "general_notifications",
    );
  }
}
