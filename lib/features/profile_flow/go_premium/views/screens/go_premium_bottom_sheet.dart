import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/profile_flow/go_premium/controllers/premium_controller.dart';

class PremiumBottomSheet extends StatelessWidget {
  const PremiumBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final PremiumController premiumController = Get.find();

    return Container(
      height: 650.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              // Container(
              //   height: 4.h,
              //   width: 40.w,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade300,
              //     borderRadius: BorderRadius.circular(2.r),
              //   ),
              // ),
              SizedBox(height: 24.h),

              // Title
              Text(
                'Upgrade to Premium',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  color: const Color(0xFF212121),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),

              // Subtitle
              Text(
                'Get priority matches, exclusive application alerts, and more with our Premium plan.',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  color: const Color(0xFF616161),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 32.h),
              CustomButton(
                text: 'Upgrade Now',
                onPressed: premiumController.onUpgradeNow,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: 'Not Now',
                onPressed: premiumController.onNotNow,
                buttonColor: Colors.white,
                borderColor: const Color(0xFF0E55FD),
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0E55FD),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
