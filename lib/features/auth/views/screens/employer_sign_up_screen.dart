import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/auth/controllers/sign_up_controller.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/features/auth/views/widgets/social_button.dart';
import 'package:quick_job/routes/app_routes.dart';

class EMPLOYEERignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.find<SignUpController>();

  EMPLOYEERignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
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
                const SizedBox(height: 32),
                // CustomInputField(
                //   label: 'First Name',
                //   hint: 'Enter your first name',
                //   controller: signUpController.firstNameTEController,
                // ),
                // const SizedBox(height: 16),
                // CustomInputField(
                //   label: 'Last Name',
                //   hint: 'Enter your last name',
                //   controller: signUpController.lastNameTEController,
                // ),
                CustomInputField(
                  label: "Full Name",
                  hint: "Enter your full name",
                  controller: signUpController.fullNameTEController,
                  validator: AppValidator.validateNotEmpty,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  controller: signUpController.phoneTEController,
                  validator: AppValidator.validateNotEmpty,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: signUpController.emailTEController,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomInputField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: signUpController.passwordTEController,
                    isPassword: true,
                    obscureText: !signUpController.isPasswordVisible.value,
                    validator: AppValidator.validatePassword,
                    onVisibilityToggle:
                        signUpController.togglePasswordVisibility,
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       'Forgot Password?',
                //       style: TextStyle(
                //         color: Color(0xFF0E55FD),
                //         fontSize: 14,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log(
                        "validate : ${signUpController.fullNameTEController.text}",
                      );
                      Get.toNamed(AppRoute.enterpriseScreen);
                    }
                    log("valskfgfgdjfs");
                  },
                ),
                const SizedBox(height: 32),
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
                    SocialButton(logoPath: LogoPath.google, onTap: () {}),
                    const SizedBox(width: 12),
                    // SocialButton(logoPath: LogoPath.facebook, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 32),

                // Center(
                //   child: Text.rich(
                //     TextSpan(
                //       children: [
                //         TextSpan(
                //           text: 'Do you have an account?',
                //           style: getTextStyle(
                //             // color: Color(0xFF757575),
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.black4,
                //           ),
                //         ),
                //         const TextSpan(text: ' '),

                //         TextSpan(
                //           text: 'Sign In',
                //           style: getTextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.primaryBlue,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
    );
  }
}
