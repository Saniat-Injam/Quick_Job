import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

import '../../utils/constants/app_colors.dart';

Future<void> loadingProgressIndicator({String? title}) async {
  if (!(Get.isDialogOpen ?? false)) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.bluePrimary,
        insetPadding: EdgeInsets.symmetric(horizontal: 140.w),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 25.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SpinKitWave(color: AppColors.textWhite, size: 24.h),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: title ?? "Processing...",
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }
  await Future.delayed(Duration(milliseconds: 1500)); //
}

Future<void> hideProgressIndicator() async {
  await Future.delayed(Duration(milliseconds: 100));
  if (Get.isDialogOpen ?? false) {
    try {
      Get.back();
    } catch (e) {
      // Handle any errors that may occur while closing the dialog
      debugPrint('Error closing progress indicator dialog: $e');
    }
  }
}
