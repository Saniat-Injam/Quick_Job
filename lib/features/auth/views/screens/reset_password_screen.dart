// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/custom/custom_appbar.dart';
// import 'package:quick_job/core/custom/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/features/auth/controllers/reset_password_controller.dart';
// import 'package:quick_job/core/custom/custom_input_field.dart';
// import 'package:quick_job/features/auth/views/widgets/primary_button.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   ResetPasswordScreen({super.key});

//   final ResetPasswordController controller = Get.put(ResetPasswordController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAppBar(backgroundColor: AppColors.transparent),
//               const SizedBox(height: 32),
//               // Title
//               Text(
//                 "Reset\nyour password",
//                 style: getTextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                   height: 1.3,
//                 ),
//               ),
//               const SizedBox(height: 12),

//               Text(
//                 "Enter the phone number or email associated with your account and we’ll send you OTP to reset your password",
//                 style: getTextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               CustomInputField(
//                 label: "Phone number/Email",
//                 hint: "Enter your phone number/email",
//                 controller: controller.emailPhoneController,
//               ),
//               const Spacer(),
//               Obx(
//                 () => PrimaryButton(
//                   text: "Get OTP",
//                   onPressed: controller.getOtp,
//                   isLoading: controller.isLoading.value,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/auth/controllers/reset_password_controller.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/features/auth/views/widgets/primary_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(backgroundColor: AppColors.transparent),
              SizedBox(height: 32.h),

              // Title
              Text(
                "Reset\nyour password",
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Enter the phone number or email associated with your account and we’ll send you OTP to reset your password",
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32.h),

              CustomInputField(
                label: "Phone number/Email",
                hint: "Enter your phone number/email",
                controller: controller.emailPhoneController,
              ),

              const Spacer(),
              Obx(
                () => PrimaryButton(
                  text: "Get OTP",
                  onPressed: () async {
                    await controller.sendForgotPasswordOTP(
                      controller.emailPhoneController.text,
                    );
                  },
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
