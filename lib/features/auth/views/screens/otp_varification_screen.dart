import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/auth/controllers/varification_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  final VerificationController controller = Get.find<VerificationController>();

  OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments ?? {};
    final String email = arguments['email'] ?? '';
    final String reason = arguments['reason'] ?? '';
    final String verifyToken = arguments['verifyToken'] ?? '';

    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(backgroundColor: AppColors.transparent),
              SizedBox(height: 20.h),

              // Title
              Text(
                'Enter verification code',
                style: getTextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackSecondary,
                ),
              ),
              SizedBox(height: 10.h),

              // Subtitle
              Text(
                'The verification code has been sent to email $email. Please enter the code to continue.',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black4,
                  height: 1.5.h,
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Input
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Pinput(
                    controller: controller.otpController,
                    length: 4,
                    onChanged: (otp) {
                      controller.otpCode = otp;
                      log("OTP Code entered: $otp");
                    },
                    defaultPinTheme: PinTheme(
                      width: 77.75,
                      height: 56,
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.borderPrimary),
                      ),
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      width: 77.75,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.blue),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      width: 77.75,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.blue),
                        color: Colors.blue.shade50,
                      ),
                    ),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Resend code
              Center(
                child: Obx(
                  () => TextButton(
                    onPressed: controller.remainingSeconds.value == 0
                        ? () => controller.resendCode()
                        : null,
                    child: Text(
                      controller.remainingSeconds.value == 0
                          ? 'Resend Code'
                          : 'Resend Code (0:${controller.remainingSeconds.value.toString().padLeft(2, '0')})',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: controller.remainingSeconds.value == 0
                            ? const Color(0xff212121)
                            : Colors.grey, // Show disabled state visually
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Button
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomButton(
          text: "Continue",
          onPressed: () async {
            log('OTP Code: ${controller.otpCode}');

            await controller.verifyOTP({
              'email': controller.email ?? '',
              'reason': controller.currentReason,
              "otp": controller.otpController.text,
            });
          },
        ),
      ),
    );
  }
}
