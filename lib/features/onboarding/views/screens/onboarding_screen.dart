import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/onboarding/controller/onboarding_controller.dart';
import 'package:quick_job/features/onboarding/model/onboarding_model.dart';
import 'package:quick_job/features/onboarding/views/widgets/onboarding_content.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  final OnboardingModel content = OnboardingModel(
    imagePath: ImagePath.onboarding,
    title: 'Connecting the',
    highlightedText: 'Right Talent',
    subtitle:
        'Upload your resume and let our AI instantly scan your skills, experience, and preferences to recommend jobs tailored to you.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: OnboardingWidget(
          content: content,
          onPressed: controller.goToNextPage,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
          child: CustomButton(
            text: "Get Started",
            onPressed: controller.goToNextPage,
            borderRadius: 99,
          ),
        ),
      ),
    );
  }
}
