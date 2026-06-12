import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/message_custom_textField.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/employer_flow/home/controllers/recently_applied_candidates_controller.dart';

void forEmployeBottomSheet({
  required RecentlyAppliedCandidatesController controller,
}) {
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
                  "Age (${controller.minAge.value.toStringAsFixed(2)} to ${controller.maxAge.value.toStringAsFixed(2)})",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            RangeSlider(
              min: 1,
              max: 100,
              divisions: 99,
              values: RangeValues(
                controller.minAge.value.toDouble(),
                controller.maxAge.value.toDouble(),
              ),
              onChanged: (RangeValues values) {
                controller.minAge.value = values.start.round();
                controller.maxAge.value = values.end.round();
              },
              activeColor: AppColors.primary,
            ),

            SizedBox(height: 10.h),
            CustomDropdownField(
              label: "Language",
              hintText: "Candidate language",
              items: controller.languageList,
              selectedValue: controller.languageValue.value,
              onChanged: (value) {
                controller.changeLanguageValue(value);
              },
            ),
            // SizedBox(height: 10.h),
            // CustomDropdownField(
            //   label: "Nationality",
            //   hintText: "Candidate Nationality",
            //   items: controller.nationalityList,
            //   selectedValue: controller.nationalityValue.value,
            //   onChanged: (value) {
            //     controller.changeNationalityValue(value);
            //   },
            // ),
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
            SizedBox(height: 10.h),
            CustomDropdownField(
              label: "Online status",
              hintText: "Online status",
              items: controller.onlineStatusList,
              selectedValue: controller.onlineStatusValue.value,
              onChanged: (value) {
                controller.changeOnlineStatusValue(value);
              },
            ),

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
                          controller.refreshFunction();
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
                          controller.fetchRecentlyApplied();
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
