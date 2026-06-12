import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/features/profile_flow/go_premium/views/screens/choose_plan_screen.dart';
import 'package:quick_job/features/profile_flow/go_premium/views/screens/go_premium_bottom_sheet.dart';

class PremiumController extends GetxController {
  /// Show the Premium Bottom Sheet
  void showPremiumBottomSheet() {
    Get.bottomSheet(
      const PremiumBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Handle Upgrade action
  void onUpgradeNow() {
    Get.back();
    Future.microtask(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (Get.isDialogOpen == false) {
        Get.to(() => ChoosePlanScreen());
      }
    });
  }

  void onNotNow() {
    Get.back(); // Close the sheet
  }
}
