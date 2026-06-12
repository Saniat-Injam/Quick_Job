import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/customContiner.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/resume_upload_card.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/uploaded_file_card.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/controller/job_seeker_update_profile_controller.dart';

class CvAndOthersInfo extends StatelessWidget {
  const CvAndOthersInfo({super.key, required this.controllerForClient});

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
                text: "Upload your CV",
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
              // / Resume picker
              ResumeUploadCard(),
              SizedBox(height: 20.h),

              /// Show selected file immediately
              Obx(() {
                if (controllerForClient.isCv.value) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFormFieldBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 32),
                          child: CustomText(
                            text:
                                "🗃️ You are already select a cv for change tap choose File!",
                            maxLines: 2,
                            color: AppColors.greenPrimary,
                          ),
                        ),

                        // Positioned(
                        //   top: 0,
                        //   right: 0,
                        //   child: InkWell(
                        //     onTap: () {
                        //       updateProfileController.videoPath.value =
                        //           null;
                        //     },
                        //     child: Container(
                        //       padding: const EdgeInsets.all(4),
                        //       decoration: BoxDecoration(
                        //         color: AppColors.primary.withOpacity(0.1),
                        //         shape: BoxShape.circle,
                        //       ),
                        //       child: const Icon(Icons.close, size: 16),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }
                if (controllerForClient.selectedFile.value != null) {
                  return UploadedFileCard(
                    fileName: controllerForClient.selectedFileName,
                    fileSize: controllerForClient.selectedFileSize,
                    fileDate: '',
                    onRemove: () {
                      controllerForClient.deleteFile();
                    },
                  );
                } else {
                  return const SizedBox();
                }
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
                text: "Language skill",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              Obx(
                () => CustomDropdownField(
                  label: "Languages (Native) *",
                  hintText: "Select",
                  selectedValue: controllerForClient.nativeLang.value,
                  items: const ["ENGLISH", "SPANISH"],
                  onChanged: (value) {
                    controllerForClient.nativeLang.value = value;
                    // updateProfileController.nativeLangController.text = value;
                  },
                ),
              ),

              SizedBox(height: getHeight(10)),
              Obx(
                () => CustomDropdownField(
                  label: "Languages (Professional) *",
                  hintText: "Select",
                  selectedValue: controllerForClient.professionalLang.value,
                  items: const ["ENGLISH", "SPANISH"],
                  onChanged: (value) {
                    controllerForClient.professionalLang.value = value;
                  },
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: getHeight(20)),
        // CustomContiner(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CustomText(
        //         text: "Your current occupation",
        //         fontSize: 18.sp,
        //         fontWeight: FontWeight.w600,
        //       ),
        //       SizedBox(height: getHeight(10)),
        //       CustomInputField(
        //         label: "Occupation",
        //         hint: "Enter your occupation",
        //         controller: controllerForClient.occupationController,
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Your education qualification",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Higher education name",
                hint: "Enter you higher education name",
                controller: controllerForClient.educationController,
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
                text: "Your previous job experience",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              Obx(
                () => CustomDropdownField(
                  label: "Job Experience *",
                  hintText: "Select Experience Level",
                  items: controllerForClient.jobExperienceOptions,
                  selectedValue: controllerForClient.jobExperienceType.value,
                  onChanged: controllerForClient.selectedJobExperience,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
