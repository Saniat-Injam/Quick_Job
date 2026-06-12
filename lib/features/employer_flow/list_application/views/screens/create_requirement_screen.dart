import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/create_post_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/widget/custom_popup_screen.dart';

class CreateRequiredmentScreen extends StatelessWidget {
  CreateRequiredmentScreen({super.key});

  final controller = Get.find<CreateJobPostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: "Create Requirements",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Requirements",
                    fontSize: 18.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  if (controller.allRequerdMent.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.allRequerdMent.length,
                      itemBuilder: (context, index) {
                        final data = controller.allRequerdMent[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: _confarmationTextAdd(text: data),
                        );
                      },
                    ),
                  ],
                  SizedBox(height: 24.h),
                  _iconBtnContainer(
                    onClick: () {
                      showCustomBottomSheet(
                        controller: controller.typeRequardment,
                        title: "Add New Requirements",
                        onSubmit: () => controller.addData(),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 36.h,
          top: 36.h,
        ),
        child: Obx(() {
          return CustomSubmitButton(
            text: controller.isLoading.value
                ? "Posting..."
                : "Post Job Vacancy",
            onTap: () {
              if (!controller.isLoading.value) {
                if (controller.allRequerdMent.isEmpty) {
                  Get.to(() => CustomPopupScreen(isConfirm: true));
                } else {
                  controller.createJobPost();
                }
              }
            },
            color: controller.isLoading.value
                ? AppColors.bluePrimary.withValues(alpha: 0.5)
                : AppColors.bluePrimary,
            borderRadius: BorderRadius.circular(8),
          );
        }),
      ),
    );
  }
}

Widget _iconBtnContainer({required VoidCallback onClick}) {
  return InkWell(
    onTap: onClick,
    child: Container(
      padding: EdgeInsets.all(12.0.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bluePrimary, width: 1.5),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4.0.h),
            decoration: BoxDecoration(
              color: AppColors.bluePrimary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, size: 14.sp, color: AppColors.textWhite),
          ),
          SizedBox(width: 8.h),
          CustomText(
            text: "Add New Requirements",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.bluePrimary,
          ),
        ],
      ),
    ),
  );
}

Widget _confarmationTextAdd({required String text}) {
  return Container(
    padding: EdgeInsets.all(10.0.h),
    decoration: BoxDecoration(
      color: AppColors.confarmationColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Image.asset(
          IconPath.confarmationIcon,
          color: AppColors.greenPrimary,
          height: 24.h,
          width: 24.w,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomText(
            text: text,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.greenPrimary,
          ),
        ),
      ],
    ),
  );
}

void showCustomBottomSheet({
  required String title,
  required TextEditingController controller,
  required VoidCallback onSubmit,
}) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.epilogue(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 12.h),
          CustomTextFormField(
            controller: controller,
            hintText: "Enter text...",
          ),
          SizedBox(height: 20.h),
          CustomSubmitButton(
            text: "Add",
            onTap: onSubmit,
            color: AppColors.bluePrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
