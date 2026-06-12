import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void showLogoutDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 5,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logout Icon
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Icon(Icons.logout, size: 40.sp, color: Colors.black87),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              "Logout",
              style: getTextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            // Description
            Text(
              "Are you sure you want to logout from the application?",
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
            ),
            SizedBox(height: 25.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      log("I am clicking");
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.bluePrimary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "Cancel",
                      style: getTextStyle(
                        color: AppColors.bluePrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       debugPrint("User Logged Out");
                //       AuthService.logoutUser();
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.bluePrimary,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       padding: EdgeInsets.symmetric(vertical: 12.h),
                //     ),
                //     child: Text(
                //       "Yes, Logout",
                //       style: TextStyle(color: Colors.white, fontSize: 16.sp),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      debugPrint("User Logged Out");
                      await ZegoUIKitPrebuiltCallInvitationService().uninit();
                      await AuthService.logoutUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bluePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Yes, Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
