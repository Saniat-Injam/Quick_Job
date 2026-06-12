import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/message_custom_textField.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/controllers/home_controller.dart';

void forJobSeekerBottomSheet({required HomeController controller}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: "Filter",
              textAlign: TextAlign.start,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),
            CustomText(
              text:
                  "Salary (${controller.formattedSalaryMin} to ${controller.formattedSalaryMax})",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            RangeSlider(
              min: 100,
              max: 100000,
              divisions: 999, // step ≈ 100
              values: RangeValues(
                controller.minSalary.value.clamp(100.0, 100000.0),
                controller.maxSalary.value.clamp(100.0, 100000.0),
              ),
              onChanged: (RangeValues values) {
                controller.minSalary.value = values.start;
                controller.maxSalary.value = values.end;
              },
              activeColor: AppColors.primary,
            ),

            // SizedBox(height: 10.h),
            // CustomDropdownField(
            //   label: "Category",
            //   hintText: "Job category",
            //   items: controller.categoryList,
            //   selectedValue: controller.categoryValue.value,
            //   onChanged: (value) {
            //     controller.changeCategoryValue(value);
            //   },
            // ),
            SizedBox(height: 10.h),
            CustomDropdownField(
              label: "Job type",
              hintText: "Job type",
              items: controller.jobTypeList,
              selectedValue: controller.jobTypeValue.value,
              onChanged: (value) {
                controller.changeJobTypeValue(value);
              },
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Location",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: controller.locationController,
              hintText: "Candidate Location",
            ),

            // SizedBox(height: 10.h),
            // CustomDropdownField(
            //   label: "Language",
            //   hintText: "Language",
            //   items: controller.languageList,
            //   selectedValue: controller.languageValue.value,
            //   onChanged: (value) {
            //     controller.changeLanguageValue(value);
            //   },
            // ),
            SizedBox(height: 50.h),
            Row(
              children: [
                Expanded(
                  child: CustomOutlineButton(
                    text: "Reset",
                    onPressed: () {
                      Get.back();
                      Future.microtask(() async {
                        await Future.delayed(const Duration(milliseconds: 200));
                        if (Get.isDialogOpen == false) {
                          controller.fetchJobs(isRefresh: true);
                        }
                      });
                    },
                    borderColor: AppColors.primary,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: CustomSubmitButton(
                    text: "Submit",
                    onTap: () {
                      Get.back();
                      Future.microtask(() async {
                        await Future.delayed(const Duration(milliseconds: 200));
                        if (Get.isDialogOpen == false) {
                          controller.fetchJobs();
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    ),
    isDismissible: true,

    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
