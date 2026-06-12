import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/customContiner.dart';
import 'package:quick_job/core/common/widgets/custom_dottet_continer.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/controller/job_seeker_update_profile_controller.dart';

class IntroVideoAndLocation extends StatelessWidget {
  const IntroVideoAndLocation({super.key, required this.controllerForClient});

  final JobSeekerUpdateProfileController controllerForClient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomContiner(
          child: Column(
            children: [
              CustomText(
                text: "Intro video",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(8)),
              CustomText(
                text: "This will help represent you and your skills.!",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: getHeight(10)),
              Obx(() {
                if (controllerForClient.isVideo.value) {
                  return GestureDetector(
                    onTap: () {
                      log("Change video");

                      controllerForClient.pickVideo();
                    },
                    child: CustomContiner(
                      child: Row(
                        children: [
                          Icon(
                            Icons.video_call,
                            size: 24.sp,
                            color: AppColors.greenPrimary,
                          ),
                          SizedBox(width: getWidth(10)),
                          Expanded(
                            child: CustomText(
                              text:
                                  "You have already selected a intro video for change this tap here..",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greenPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (controllerForClient.videoPath.value != null) {
                  return GestureDetector(
                    onTap: () {
                      log("Change video");

                      controllerForClient.pickVideo();
                    },
                    child: CustomContiner(
                      child: Row(
                        children: [
                          Icon(
                            Icons.video_call,
                            size: 24.sp,
                            color: AppColors.bluePrimary,
                          ),
                          SizedBox(width: getWidth(10)),
                          Expanded(
                            child: CustomText(
                              text:
                                  "You have selected a intro video for change this tap here..",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bluePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(8),
                    //   child: Image.file(
                    //     controllerForClient.selectedCompanyLogoImage.value!,
                    //     height: getHeight(50),
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  );
                }
                return CustomDottetContiner(
                  text: "Select your intro video",
                  onTap: () {
                    log("Click for intro video");
                    controllerForClient.pickVideo();
                  },
                );
              }),
            ],
          ),
        ),
        SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Your Location",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Address",
                hint: "Enter your address",
                controller: controllerForClient.addressController,
              ),
            ],
          ),
        ),
        SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Your current occupation",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Occupation",
                hint: "Enter your occupation",
                controller: controllerForClient.occupationController,
              ),
            ],
          ),
        ),
        SizedBox(height: getHeight(20)),
        // CustomContiner(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CustomText(
        //         text: "Your education qualification",
        //         fontSize: 18.sp,
        //         fontWeight: FontWeight.w600,
        //       ),
        //       SizedBox(height: getHeight(10)),
        //       CustomInputField(
        //         label: "Higher education name",
        //         hint: "Enter you higher education name",
        //         controller: controllerForClient.educationController,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Write something yourself",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "description",
                hint: "Write here...",
                controller: controllerForClient.descriptionController,
                maxLine: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
