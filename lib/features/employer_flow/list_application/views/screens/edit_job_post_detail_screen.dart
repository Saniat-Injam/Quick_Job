import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/edit_job_post_detail_controller.dart';

class EditJobPostDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? jobData;

  EditJobPostDetailScreen({super.key, this.jobData});

  final controller = Get.put(EditJobPostDetailController());

  @override
  Widget build(BuildContext context) {
    if (jobData != null) {
      _initializeControllerWithJobData();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 36.0.h, left: 10.0.w, right: 10.0.w),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: "Details",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.w, bottom: 16.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // ---- Tabs ----
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton(
                    index: 0,
                    title: "Job Details",
                    controller: controller,
                  ),
                  _buildTabButton(
                    index: 1,
                    title: "Requirements",
                    controller: controller,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ---- Tab content ----
            Expanded(
              child: Obx(() {
                if (controller.selectedTab.value == 0) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Image.asset(
                                ImagePath.uiUxDesigner,
                                width: 60.w,
                                height: 60.h,
                                fit: BoxFit.contain,
                              ),
                              // Positioned(
                              //   bottom: 0,
                              //   right: 0,
                              //   child: Container(
                              //     padding: EdgeInsets.all(8.0.h),
                              //     decoration: BoxDecoration(
                              //       color: AppColors.bluePrimary,
                              //       borderRadius: BorderRadius.circular(8),
                              //     ),
                              //     child: Image.asset(
                              //       IconPath.editIcon,
                              //       color: AppColors.textWhite,
                              //       height: 10.h,
                              //       width: 10.h,
                              //       fit: BoxFit.contain,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Divider(color: AppColors.textFormFieldBorder),
                        SizedBox(height: 24.h),
                        requeidRichTect(text: "Open Position"),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: controller.namePositionController,
                          hintText: "Name Position",
                          containerColor: AppColors.textWhite,
                          containerBorderColor: AppColors.cardBorder,
                        ),
                        SizedBox(height: 16.h),
                        requeidRichTect(text: "Salary"),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: controller.salaryController,
                          hintText: "Salary per month",
                          containerColor: AppColors.textWhite,
                          containerBorderColor: AppColors.cardBorder,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                        SizedBox(height: 16.h),
                        requeidRichTect(text: "Location"),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: controller.locationController,
                          hintText: "Location",
                          containerColor: AppColors.textWhite,
                          containerBorderColor: AppColors.cardBorder,
                        ),
                        SizedBox(height: 16.h),
                        requeidRichTect(text: "Type"),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hintText: "Type",
                          items: controller.jobTypeList,
                          selectedValue: controller.seletedType.value,
                          onChanged: controller.seletedTroggleType,
                        ),
                        SizedBox(height: 16.h),
                        // requeidRichTect(text: "Work Arrangement"),
                        // SizedBox(height: 8.h),
                        // CustomDropdownField(
                        //   hintText: "Type",
                        //   items: controller.workTypeList,
                        //   selectedValue: controller.seletedWorkType.value,
                        //   onChanged: controller.seletedTroggleTypeWork,
                        // ),
                      ],
                    ),
                  );
                } else {
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
                              child: _confarmationTextAdd(
                                text: data,
                                onDelete: () {
                                  controller.removeRequirement(index);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                      SizedBox(height: 24.h),
                      _iconBtnContainer(
                        onClick: () {
                          showCustomBottomSheet(
                            controller: controller.jobTypeController,
                            title: "Add New Requirements",
                            onSubmit: () => controller.addData(),
                          );
                        },
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: EdgeInsets.only(
            top: 20.0.h,
            left: 16.w,
            right: 16.w,
            bottom: 34.h,
          ),
          child: CustomSubmitButton(
            text: controller.isLoading.value ? "Updating..." : "Update Vacancy",
            onTap: controller.isLoading.value
                ? () {}
                : () {
                    final jobId =
                        jobData?['id']?.toString() ?? controller.jobId.value;
                    debugPrint('Calling updateVacancy with ID: $jobId');
                    controller.updateVacancy(jobId);
                  },
            borderRadius: BorderRadius.circular(8),
            color: AppColors.bluePrimary,
          ),
        );
      }),
    );
  }

  // Initialize controller with job data
  void _initializeControllerWithJobData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (jobData != null) {
        debugPrint('Job Data: $jobData');
        debugPrint('Job ID: ${jobData!['id']}');
        controller.populateFieldsFromJobData(jobData!);
      } else {
        debugPrint('Job Data is NULL!');
      }
    });
  }
}

// ---- Custom Tab Button ----
Widget _buildTabButton({
  required int index,
  required String title,
  required EditJobPostDetailController controller,
}) {
  final isSelected = controller.selectedTab.value == index;
  return GestureDetector(
    onTap: () => controller.changeTab(index),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.bluePrimary : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.bluePrimary),
      ),
      child: CustomText(
        text: title,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: isSelected ? Colors.white : AppColors.bluePrimary,
      ),
    ),
  );
}

Widget requeidRichTect({required String text}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: GoogleFonts.epilogue(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      children: [
        TextSpan(
          text: '*',
          style: GoogleFonts.epilogue(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  );
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

Widget _confarmationTextAdd({
  required String text,
  required VoidCallback onDelete,
}) {
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
        GestureDetector(
          onTap: onDelete,
          child: Icon(Icons.close, color: AppColors.greenPrimary, size: 18.sp),
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
