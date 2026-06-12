import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller_for_client.dart';

class EmployerPersonalInfo extends StatelessWidget {
  const EmployerPersonalInfo({super.key, required this.controllerForClient});

  final EmployerEditProfileControllerForClient controllerForClient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stack(
        //   children: [
        //     Obx(
        //       () => Container(
        //         width: double.infinity,
        //         height: getHeight(220),
        //         decoration: BoxDecoration(
        //           gradient: AppColors.primaryGradient,
        //           borderRadius: BorderRadius.circular(16),
        //         ),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(16),
        //           child: controllerForClient.selectedUserImage.value != null
        //               ? Image.file(
        //                   controllerForClient.selectedUserImage.value!,
        //                   width: double.infinity,
        //                   fit: BoxFit.cover,
        //                 )
        //               : SizedBox.shrink(),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: getHeight(20),
        //       left: getWidth(20),
        //       child: GestureDetector(
        //         onTap: () {
        //           log("Get my image");
        //           controllerForClient.pickImageForUser();
        //         },
        //         child: Container(
        //           padding: EdgeInsets.all(getHeight(8)),
        //           decoration: BoxDecoration(
        //             color: AppColors.textPrimary.withAlpha(150),
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //           child: Icon(
        //             Icons.image,
        //             size: 16.sp,
        //             color: AppColors.textWhite,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        // SizedBox(height: getHeight(20)),
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
          controller: controllerForClient.fullNameController,
          validator: AppValidator.validateNotEmpty,
        ),

        // SizedBox(height: getHeight(10)),
        // CustomInputField(
        //   label: 'Last name',
        //   hint: 'Enter your last name',
        //   controller: controllerForClient.lastNameController,
        //   // validator: AppValidator.validateEmail,
        // ),
        // SizedBox(height: getHeight(10)),
        // CustomInputField(
        //   label: 'Phone number',
        //   hint: 'Enter your phone number',
        //   controller: controllerForClient.phoneNumberController,
        //   keyboardType: TextInputType.numberWithOptions(),
        //   // validator: AppValidator.validateEmail,
        // ),
        // SizedBox(height: getHeight(10)),
        // CustomInputField(
        //   label: 'Your role in the heiring process',
        //   hint: 'Enter your role',
        //   controller: controllerForClient.yourRoleController,
        //   // validator: AppValidator.validateEmail,
        // ),
        CustomText(
          text: 'What is your role in this company?',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.blackSecondary,
        ),

        // const SizedBox(height: 16),
        Obx(
          () => CustomDropdownField(
            hintText: "Owner",
            items: controllerForClient.companyRole,
            selectedValue: controllerForClient
                .selctedCompanyRole
                .value, // This should be a String
            onChanged: controllerForClient.changeCompanyRole,
          ),
        ),
      ],
    );
  }
}
