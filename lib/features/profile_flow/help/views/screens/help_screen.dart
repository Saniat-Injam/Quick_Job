import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/profile_flow/help/views/screens/faq_screen.dart';
import 'package:quick_job/features/profile_flow/help/views/screens/privacy_policy_screeen.dart';
import 'package:quick_job/features/profile_flow/help/views/screens/terms_and_condition_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SizedBox(height: 60.h),
          CustomAppBar(title: "Help", backgroundColor: AppColors.transparent),
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Column(
              children: [
                InkWell(
                  onTap: () => Get.to(() => FaqScreen()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FAQ",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2C3E50),
                          ),
                        ),
                        SvgPicture.asset(IconPath.rightAngle),
                      ],
                    ),
                  ),
                ),
                Divider(color: Color(0xffF3F4F6), thickness: 1.5),
                InkWell(
                  onTap: () => Get.to(() => TermsAndConditionScreen()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Terms & Conditions",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2C3E50),
                          ),
                        ),
                        SvgPicture.asset(IconPath.rightAngle),
                      ],
                    ),
                  ),
                ),
                Divider(color: Color(0xffF3F4F6), thickness: 1.5),

                InkWell(
                  onTap: () => Get.to(() => PrivacyPolicyScreeen()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Privacy Policy",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2C3E50),
                          ),
                        ),
                        SvgPicture.asset(IconPath.rightAngle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
