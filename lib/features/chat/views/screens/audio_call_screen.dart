import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/chat/controllers/audio_call_controller.dart';

class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileAlertController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Calling...",
              height: 100.h,
              margin: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),

            SizedBox(height: 114.h),
            Container(
              width: 345.w,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profile image
                  Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      image: DecorationImage(
                        image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Name & phone
                  Obx(
                    () => Column(
                      children: [
                        Text(
                          controller.name.value,
                          style: getTextStyle(
                            color: Colors.black,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          controller.phone.value,
                          style: getTextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 56.h),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          IconPath.redDial,
                          width: 60.w,
                          height: 60.w,
                        ),
                      ),
                      SizedBox(width: 40.w),

                      SvgPicture.asset(
                        IconPath.greenDial,
                        width: 60.w,
                        height: 60.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
