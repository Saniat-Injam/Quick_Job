import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/create_post_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/create_requirement_screen.dart';

class CreateJobPostScreen extends StatelessWidget {
  CreateJobPostScreen({super.key});

  final controller = Get.find<CreateJobPostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: "Create Post",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: Stack(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           image: DecorationImage(
              //             image:
              //                 controller.jobVacancyImage.value.startsWith(
              //                   'http',
              //                 )
              //                 ? NetworkImage(controller.jobVacancyImage.value)
              //                 : AssetImage(ImagePath.user) as ImageProvider,
              //             fit: BoxFit.cover,
              //           ),
              //         ),

              //         child: Image.asset(
              //           ImagePath.uiUxDesigner,
              //           width: 100.w,
              //           height: 100.h,
              //           fit: BoxFit.contain,
              //         ),
              //       ),
              //       Positioned(
              //         bottom: 0,
              //         right: 0,
              //         child: InkWell(
              //           onTap: () => controller.pickImage(),
              //           child: Container(
              //             padding: EdgeInsets.all(8.0.h),
              //             decoration: BoxDecoration(
              //               color: AppColors.bluePrimary,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Image.asset(
              //               IconPath.editIcon,
              //               color: AppColors.textWhite,
              //               height: 8.h,
              //               width: 8.w,
              //               fit: BoxFit.contain,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: controller.jobVacancyImage.value.isNotEmpty
                              ? (controller.jobVacancyImage.value.startsWith(
                                      'http',
                                    )
                                    ? NetworkImage(
                                        controller.jobVacancyImage.value,
                                      )
                                    : FileImage(
                                            File(
                                              controller.jobVacancyImage.value,
                                            ),
                                          )
                                          as ImageProvider)
                              : AssetImage(ImagePath.uiUxDesigner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: InkWell(
                    //     // onTap: () => controller.pickImage(),
                    //     child: Container(
                    //       padding: EdgeInsets.all(8.0.h),
                    //       decoration: BoxDecoration(
                    //         color: AppColors.bluePrimary,
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       // child: Image.asset(
                    //       //   IconPath.editIcon,
                    //       //   color: AppColors.textWhite,
                    //       //   height: 8.h,
                    //       //   width: 8.w,
                    //       //   fit: BoxFit.contain,
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Divider(color: AppColors.textFormFieldBorder),
              SizedBox(height: 24.h),

              // Job Position
              levelText(text: "Open Position"),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: controller.namePositionController,
                hintText: "Name Position",
                containerColor: AppColors.textWhite,
                containerBorderColor: AppColors.cardBorder,
              ),
              SizedBox(height: 16.h),

              // Salary
              levelText(text: "Salary"),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: controller.seleryController,
                hintText: "Salary per month",
                containerColor: AppColors.textWhite,
                containerBorderColor: AppColors.cardBorder,
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(height: 16.h),

              // Location
              levelText(text: "Location"),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: controller.locationController,
                hintText: "Location",
                containerColor: AppColors.textWhite,
                containerBorderColor: AppColors.cardBorder,
              ),
              SizedBox(height: 16.h),

              // Job Type
              levelText(text: "Job Type"),
              SizedBox(height: 8.h),
              Obx(
                () => CustomDropdownField(
                  hintText: "Select Job Type",
                  items: controller.jobTypeList,
                  selectedValue: controller.seletedType.value,
                  onChanged: controller.seletedTroggleType,
                ),
              ),
              SizedBox(height: 16.h),

              // Work
              levelText(text: "Work Arrangement"),
              SizedBox(height: 8.h),
              Obx(
                () => CustomDropdownField(
                  hintText: "Select Work Arrangement",
                  items: controller.workTypeList,
                  selectedValue: controller.seletedWorkType.value,
                  onChanged: controller.seletedTroggleTypeWork,
                ),
              ),
              SizedBox(height: 16.h),

              // Job Category
              levelText(text: "Job Category"),
              SizedBox(height: 8.h),
              Obx(
                () => CustomDropdownField(
                  hintText: "Select Job Category",
                  items: controller.jobCategoryList,
                  selectedValue: controller.seletedJobCategory.value,
                  onChanged: controller.seletedTroggleJobCategory,
                ),
              ),
              SizedBox(height: 40.h),
              Obx(
                () => GestureDetector(
                  onTap: controller.isFormValid.value
                      ? () {
                          Get.to(() => CreateRequiredmentScreen());
                        }
                      : null,
                  child: CustomSubmitButton(
                    text: "Next",
                    onTap: controller.isFormValid.value
                        ? () {
                            Get.to(() => CreateRequiredmentScreen());
                          }
                        : () {}, // Empty callback for disabled state
                    borderRadius: BorderRadius.circular(8),
                    textColor: controller.isFormValid.value
                        ? AppColors.textWhite
                        : AppColors.textGrey,
                    color: controller.isFormValid.value
                        ? AppColors.bluePrimary
                        : AppColors.whiteGray,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

Widget levelText({required String text}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: getTextStyle(
        color: AppColors.black3,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      children: [
        TextSpan(
          text: '*',
          style: getTextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  );
}
