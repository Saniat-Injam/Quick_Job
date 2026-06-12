import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';

import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/profile_flow/help/controllers/privacy_policy_controller.dart';

class PrivacyPolicyScreeen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Scaffold with a top area that looks like the screenshot
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              CustomAppBar(
                title: "Privacy Policy",
                backgroundColor: AppColors.transparent,
              ),

              SizedBox(height: 18.h),

              // White rounded container that holds the privacy policy text
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.black.withOpacity(0.03),
                      //   blurRadius: 12.r,
                      //   offset: Offset(0, 6.h),
                      // ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 16.h,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        //physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.privacyText.value,
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1.6,
                                      color: Color(0xff4B5563),
                                    ),
                                  ),
                                ),
                                // If you want more spacing at bottom
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 12.h),
              // bottom notch-like indicator (optional, from screenshot)
              Container(
                width: 80.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
