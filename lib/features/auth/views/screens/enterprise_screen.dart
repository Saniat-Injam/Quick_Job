import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/auth/controllers/sign_up_controller.dart';

import '../../../../core/common/widgets/custom_textformfield.dart';
import '../../../../core/custom/my_widgets/custom_appbar.dart';
import '../../../../core/custom/my_widgets/custom_input_field.dart';
import '../../../../core/utils/constants/app_colors.dart';

class EnterpriseScreen extends StatelessWidget {
  EnterpriseScreen({super.key});
  final controller = Get.find<SignUpController>();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    backgroundColor: AppColors.transparent,
                    title: 'Enterprise',
                  ),
                  CustomText(
                    text: 'Company Information',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackSecondary,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Company Name',
                    hint: 'Enter Company Name',
                    controller: controller.companyNameTEController,
                    validator: AppValidator.validateNotEmpty,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Zip Code',
                    hint: 'Enter Zip Code',
                    controller: controller.zipCodeTEController,
                    validator: AppValidator.validateNotEmpty,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Company Email',
                    hint: 'Enter Company Email',
                    controller: controller.companyEmailTEController,
                    validator: AppValidator.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Company Phone Number',
                    hint: 'Enter Company Phone Number',
                    controller: controller.companyPhoneTEController,
                    validator: AppValidator.validateNotEmpty,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Website',
                    hint: 'Enter Website',
                    controller: controller.websiteTEController,
                    validator: AppValidator.validateNotEmptyWithAll,
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: controller.companyCountryTEController,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.pickCountry(context);
                      },
                      child: const Icon(Icons.location_on),
                    ),
                    hintText: 'Select country/region',
                    validator: AppValidator.validateNotEmptyWithAll,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: controller.companyEstablishTEController,
                    validator: AppValidator.validateNotEmptyWithAll,

                    hintText: "Establishment Date",
                    readonly: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.pickDate(context);
                      },
                      child: const Icon(Icons.calendar_month_rounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Address',
                    hint: 'Enter Address',
                    controller: controller.companyAddressTEController,
                    validator: AppValidator.validateNotEmpty,
                  ),
                  // const SizedBox(height: 16),
                  // CustomInputField(
                  //   label: 'Industry',
                  //   hint: 'Enter Industry',
                  //   controller: controller.industryTEController,
                  //   validator: AppValidator.validateNotEmpty,
                  // ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Description',
                    hint: 'Enter Description',
                    controller: controller.descriptionTEController,
                    validator: AppValidator.validateNotEmptyWithAll,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.requestToRegisterAccount();
                      }
                      log("sdfsdf");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
