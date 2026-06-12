import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/google_auth_service.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/auth/controllers/login_controller.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/features/auth/views/widgets/social_button.dart';
import 'package:quick_job/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  final LoginController loginController;

  LoginScreen({super.key, required this.role})
    : loginController = Get.put(LoginController(role: role));

  // final GoogleAuthService googleAuthService = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(backgroundColor: AppColors.transparent),
                SizedBox(height: 24.h),
                Text(
                  'Let’s\nsign you in!',
                  style: getTextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 32.h),
                CustomInputField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: loginController.emailController,
                  validator: AppValidator.validateEmail,
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => CustomInputField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: loginController.passwordController,
                    isPassword: true,
                    obscureText: !loginController.isPasswordVisible.value,
                    onVisibilityToggle:
                        loginController.togglePasswordVisibility,
                    validator: AppValidator.validatePassword,
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.resetPasswordScreen);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: getTextStyle(
                        color: const Color(0xFF0E55FD),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginController.login();
                    }
                  },
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: const Color(0xFFE0E0E0),
                        thickness: 1.r,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        'OR SIGN IN WITH',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: const Color(0xFFE0E0E0),
                        thickness: 1.r,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocialButton(
                //       logoPath: LogoPath.google,
                //       onTap: () {
                //         googleAuthService.sendGoogleUserDataToBackend();
                //       },
                //     ),
                //     SizedBox(width: 12.w),
                //     //SocialButton(logoPath: LogoPath.facebook, onTap: () {}),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SocialButton(
                    //   logoPath: LogoPath.google,
                    //   onTap: () async {
                    //     final userCredential = await googleAuthService
                    //         .signInWithGoogle();

                    //     if (userCredential != null) {
                    //       // Only send data to backend if sign-in was successful
                    //       await googleAuthService.sendGoogleUserDataToBackend();
                    //     } else {
                    //       // Optionally show an error
                    //       AppSnackBar.showError(
                    //         "Google Sign-In canceled or failed",
                    //       );
                    //     }
                    //   },
                    // ),
                    SocialButton(
                      logoPath: LogoPath.google,
                      onTap: () {
                        GoogleLoginSignup().socialLoginUser(
                          role: AuthService.role ?? "",
                        );
                        log("Role is  : ${AuthService.role}");
                        // try {
                        //   // Attempt Google Sign-In
                        //   final userCredential = await googleAuthService
                        //       .signInWithGoogle();

                        //   if (userCredential != null) {
                        //     // Send data to backend only if sign-in was successful
                        //     await googleAuthService.sendGoogleUserDataToBackend();
                        //   } else {
                        //     // User canceled or sign-in failed
                        //     AppSnackBar.showError(
                        //       "Google Sign-In canceled or failed.",
                        //     );
                        //   }
                        // } catch (e) {
                        //   // Catch any unexpected errors
                        //   AppSnackBar.showError(
                        //     "An error occurred during Google Sign-In: $e",
                        //   );
                        // }
                      },
                    ),
                    SizedBox(width: 12.w),
                  ],
                ),

                SizedBox(height: 32.h),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Sign Up',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bluePrimary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          final loginController = Get.find<LoginController>();

                          if (loginController.role == 'JOB_SEEKERS') {
                            Get.toNamed(
                              AppRoute.jobSeekerSignUpScreen,
                              arguments: {'role': 'JOB_SEEKERS'},
                            );
                          } else {
                            Get.toNamed(
                              AppRoute.signUpScreen,
                              arguments: {'role': loginController.role},
                            );
                          }
                        },
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
