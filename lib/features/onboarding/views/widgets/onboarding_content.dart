import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/onboarding/model/onboarding_model.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingModel content;
  final VoidCallback onPressed;

  const OnboardingWidget({
    super.key,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title & Image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(content.imagePath, fit: BoxFit.cover),
              const SizedBox(height: 24),

              // Title text
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${content.title} ",
                      style: getTextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackPrimary,
                        height: 1.12.h,
                      ),
                    ),
                    TextSpan(
                      text: content.highlightedText,
                      style: getTextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.bluePrimary,
                        decoration: TextDecoration.underline,
                        height: 1.12.h,
                      ),
                    ),
                    TextSpan(
                      text: '\nwith the Right Opportunities.',
                      style: getTextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackPrimary,
                        height: 1.12.h,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Text(
                content.subtitle,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black4,
                  height: 1.5.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
