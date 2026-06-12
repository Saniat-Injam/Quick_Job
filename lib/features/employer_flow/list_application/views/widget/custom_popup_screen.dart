import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/create_job_post_screen.dart';

class CustomPopupScreen extends StatelessWidget {
  const CustomPopupScreen({super.key, required this.isConfirm});

  final bool isConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 36.0.h, left: 10.0.w, right: 10.0.w),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: "Job Details",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.0.h),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadoColor,
                        offset: Offset(0, 0),
                        blurRadius: 8,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Image.asset(
                        ImagePath.uiUxDesigner,
                        height: 50.h,
                        width: 50.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          CustomText(
                            text: "UI/UX Designer",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          CustomText(
                            text: "AirBNB",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 62.h),

                Image.asset(
                  isConfirm ? ImagePath.confirmImg : ImagePath.errorImg,
                  height: 250.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: isConfirm ? "Job Posted!" : "Oops, Failed to Post",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: isConfirm ? AppColors.bluePrimary : Colors.red,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: isConfirm
                      ? "Now you can see all the applier CV/Resume and invite them to the next step. "
                      : "Please make sure that your internet connection is active and stable, then press Try Again",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                CustomSubmitButton(
                  text: isConfirm ? "Go to Applications" : "Try Again",
                  onTap: () {
                    if (isConfirm) {
                    } else {
                      Get.to(() => CreateJobPostScreen());
                    }
                  },
                  color: AppColors.bluePrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                SizedBox(height: 16.h),
                CustomOutlineButton(
                  text: isConfirm ? "Post Another" : "Back to Home",
                  onPressed: () {
                    // Get.to(() => CustomPopupScreen());
                    Get.to(() => CreateJobPostScreen());
                  },
                  borderColor: AppColors.bluePrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
