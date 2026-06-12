import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/features/auth/controllers/create_password_controller.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
class CreatePasswordScreen extends StatelessWidget {
  final CreatePasswordController createPasswordController = Get.put(
    CreatePasswordController(),
  );

  CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(backgroundColor: AppColors.transparent),
                const SizedBox(height: 24),

                Text(
                  'Create\nnew password',
                  style: getTextStyle(
                    color: Color(0xFF212121),
                    fontSize: 32,

                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                // const SizedBox(height: 16),

                // Text(
                //   'The verification code has been sent to the email. Please enter the code to continue.',
                //   style: getTextStyle(
                //     color: Colors.grey.shade600,
                //     fontSize: 14,
                //     height: 1.4,
                //   ),
                // ),
                const SizedBox(height: 40),
                //
                // CustomInputField(
                //   label: 'Old Password',
                //   hint: 'Enter new password',
                //   obscureText: true,
                //   controller: createPasswordController.oldPasswordController,
                // ),
                // const SizedBox(height: 20),

                // Confirm Password Field
                CustomInputField(
                  label: 'Set new password',
                  hint: 'Set new password',
                  obscureText: true,
                  controller: createPasswordController.newPasswordController,
                ),
                const SizedBox(height: 40),

                // Submit Button
                // Obx(
                //   () => PrimaryButton(
                //     text: createPasswordController.isLoading.value
                //         ? 'Please wait...'
                //         : 'Save Password',
                //     onPressed: createPasswordController.isLoading.value
                //         ? null
                //         : createPasswordController.submitPassword,
                //   ),
                // ),
                CustomButton(
                  text: "Save Password",
                  onPressed: () {
                    if (createPasswordController.reason ==
                        "RESET_PASSWORD_SECRET") {
                      createPasswordController.resetPassword();
                    } else {
                      createPasswordController.submitPassword();
                    }
                    // Get.snackbar(
                    //   "Successful",
                    //   "Your Password has been changed",
                    // );
                    // Get.offAllNamed(AppRoute.loginScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
