import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/google_auth_service.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/auth/controllers/job_seeker_controller.dart';
import 'package:quick_job/features/auth/views/widgets/social_button.dart';

import '../../../../core/common/widgets/custom_dropdown.dart';
import '../../../../core/common/widgets/custom_textformfield.dart';
import '../../../../core/custom/my_widgets/custom_button.dart';
import '../../../../core/custom/my_widgets/custom_input_field.dart';
import '../../../../core/custom/my_widgets/global_text_style.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../routes/app_routes.dart';

class JobSeekerSignupScreen extends StatelessWidget {
  JobSeekerSignupScreen({super.key});
  final controller = Get.find<JobSeekerController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final role = arguments['role'];
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create\nnew Account',
                    style: getTextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomInputField(
                    controller: controller.fullNameTEController,
                    label: "Full Name *",
                    hint: "Enter your full name",
                    validator: AppValidator.validateNotEmpty,
                  ),
                  SizedBox(height: 20.h),
                  CustomInputField(
                    controller: controller.emailTEController,
                    label: "Email *",
                    hint: "Enter your Email",
                    suffixIcon: Icon(Icons.email),
                    validator: AppValidator.validateEmail,
                  ),
                  SizedBox(height: 20.h),
                  CustomInputField(
                    controller: controller.phoneNumberTEController,
                    label: "Phone Number *",
                    hint: "Enter your phone number",
                    validator: AppValidator.validateNotEmpty,
                  ),
                  SizedBox(height: 20.h),
                  CustomInputField(
                    controller: controller.passwordTEController,
                    label: "Password *",
                    hint: "Enter your password",
                    validator: AppValidator.validatePassword,
                  ),
                  SizedBox(height: 20.h),

                  // Education
                  CustomInputField(
                    controller: controller.educationTEController,
                    label: "Education *",
                    hint: "Enter your education",
                    validator: AppValidator.validateNotEmpty,
                  ),
                  SizedBox(height: 20.h),
                  CustomInputField(
                    controller: controller.ageTEController,
                    label: "Age *",
                    hint: "Enter your age",
                    validator: AppValidator.validateNotEmpty,
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => CustomDropdownField(
                      label: "Gender *",
                      hintText: "Select Gender",
                      items: controller.genderType,
                      selectedValue: controller.seletedType.value,
                      onChanged: controller.seletedTroggleType,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  CustomTextFormField(
                    validator: AppValidator.validateNotEmptyWithAll,
                    controller: controller.dateTEController,
                    hintText: "Enter Birth Date",
                    readonly: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.pickDate(context);
                      },
                      child: const Icon(Icons.calendar_month_rounded),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  CustomInputField(
                    controller: controller.addressTEController,
                    label: "Address *",
                    hint: "Enter your address",
                    validator: AppValidator.validateNotEmpty,
                  ),
                  SizedBox(height: 20.h),

                  CustomInputField(
                    controller: controller.occupationTEController,
                    label: "Occupation *",
                    hint: "UI/UX Designer",
                    validator: AppValidator.validateNotEmpty,
                  ),
                  SizedBox(height: 20.h),

                  CustomInputField(
                    controller: controller.descTEController,
                    label: "Description *",
                    hint: "Tell us about yourself",
                    validator: AppValidator.validateNotEmptyWithAll,
                  ),
                  SizedBox(height: 20.h),

                  Obx(
                    () => CustomDropdownField(
                      label: "Job Experience *",
                      hintText: "Select Experience Level",
                      items: controller.jobExperienceOptions,
                      selectedValue: controller.jobExperienceType.value,
                      onChanged: controller.selectedJobExperience,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Obx(
                    () => CustomDropdownField(
                      label: "Professional Language",
                      hintText: "Select Language",
                      items: controller.language,
                      selectedValue: controller.languageType.value,
                      onChanged: controller.seletedlanguageType,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Obx(
                    () => CustomDropdownField(
                      label: "Native Language",
                      hintText: "Select Native Language",
                      items: controller.native,
                      selectedValue: controller.nativeLanguage.value,
                      onChanged: controller.seletedNativeType,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  CustomButton(
                    text: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.jobSeekerSignUp();
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'OR SIGN IN WITH',
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black4,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        logoPath: LogoPath.google,
                        onTap: () {
                          log("role is : $role");

                          GoogleLoginSignup().socialLoginUser(role: role);
                        },
                      ),
                      // const SizedBox(width: 12),
                      // SocialButton(logoPath: LogoPath.facebook, onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black4,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bluePrimary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoute.loginScreen);
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
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
