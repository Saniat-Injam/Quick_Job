import 'package:flutter/material.dart';
import 'package:get/get.dart';
// optional for colors

class LogoutController extends GetxController {
  void showLogoutDialog() {
    Get.defaultDialog(
      title: "Logout",
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: "Are you sure you want to logout from the application?",
      middleTextStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
      backgroundColor: Colors.white,
      radius: 12,
      textCancel: "Cancel",
      textConfirm: "Yes, Logout",
      cancelTextColor: Colors.blue,
      confirmTextColor: Colors.white,
      onCancel: () {
        // Close dialog
        Get.back();
      },
      onConfirm: () {
        // Add your logout logic here
        debugPrint("User logged out");
        Get.back();
      },
      buttonColor: Colors.blue,
    );
  }
}
