import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/controller/job_seeker_update_profile_controller.dart';

class JobSeekerPersonalInfo extends StatelessWidget {
  const JobSeekerPersonalInfo({super.key, required this.controller});

  final JobSeekerUpdateProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Obx(() {
              if (controller.profileImageUrl.value.isNotEmpty) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    controller.profileImageUrl.value,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Container(
                width: double.infinity,
                height: getHeight(220),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: controller.selectedUserImage.value != null
                      ? Image.file(
                          controller.selectedUserImage.value!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                ),
              );
            }),

            Positioned(
              bottom: getHeight(20),
              left: getWidth(20),
              child: GestureDetector(
                onTap: () {
                  log("Get my image");
                  controller.pickImageForUser();
                },
                child: Container(
                  padding: EdgeInsets.all(getHeight(8)),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withAlpha(150),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 16.sp,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: getHeight(20)),
        CustomText(
          text: "Personal info",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        SizedBox(height: getHeight(10)),
        CustomInputField(
          label: 'Full name',
          hint: 'Enter your full name',
          controller: controller.fullNameController,
          // validator: AppValidator.validateEmail,
        ),

        SizedBox(height: getHeight(10)),
        CustomInputField(
          label: 'Phone number',
          hint: 'Enter your phone number',
          controller: controller.phoneController,
          keyboardType: TextInputType.numberWithOptions(),
          // validator: AppValidator.validateEmail,
        ),
        SizedBox(height: getHeight(10)),
        CustomInputField(
          label: 'Your age',
          hint: 'Enter your age',
          controller: controller.ageController,
          keyboardType: TextInputType.numberWithOptions(),
        ),

        SizedBox(height: getHeight(10)),
        Obx(
          () => CustomDropdownField(
            label: "Gender *",
            hintText: "Select Gender",
            selectedValue: controller.gender.value,
            items: const ["MALE", "FEMALE"],
            onChanged: (value) {
              controller.gender.value = value;
            },
          ),
        ),

        SizedBox(height: getHeight(10)),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              initialDate: DateTime(2000),
            );
            if (picked != null) {
              controller.dobController.text = DateFormat(
                "yyyy-MM-dd",
              ).format(picked);
            }
          },
          child: AbsorbPointer(
            child: CustomInputField(
              label: "Date of Birth *",
              hint: "Select your DOB",
              controller: controller.dobController,
              validator: AppValidator.validateNotEmptyWithAll,
            ),
          ),
        ),
      ],
    );
  }
}
