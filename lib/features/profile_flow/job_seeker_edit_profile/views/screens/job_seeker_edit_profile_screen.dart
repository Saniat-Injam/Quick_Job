import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/controller/job_seeker_update_profile_controller.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/views/widgets/cv_and_others_info.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/views/widgets/intro_video_and_location.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/views/widgets/job_seeker_personal_info.dart';

class JobSeekerEditProfileScreen extends StatelessWidget {
  JobSeekerEditProfileScreen({super.key});
  final JobSeekerUpdateProfileController controller = Get.find();

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: CustomAppBar(title: "Edit profile"),
    //   body: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    //       child: SingleChildScrollView(
    //         controller: ScrollController(),
    //         child: Form(
    //           key: _formKey,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               // CustomAppBar(backgroundColor: AppColors.transparent),

    //               /// ---------- FULL NAME ----------
    //               CustomInputField(
    //                 label: "Full Name *",
    //                 hint: "Enter your full name",
    //                 controller: updateProfileController.fullNameController,
    //                 validator: AppValidator.validateNotEmpty,
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- AGE ----------
    //               CustomInputField(
    //                 label: "Age *",
    //                 hint: "Enter your age",
    //                 controller: updateProfileController.ageController,
    //                 keyboardType: TextInputType.number,
    //                 validator: AppValidator.validateNotEmpty,
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- GENDER ----------
    //               Obx(
    //                 () => CustomDropdownField(
    //                   label: "Gender *",
    //                   hintText: "Select Gender",
    //                   selectedValue: updateProfileController.gender.value,
    //                   items: const ["MALE", "FEMALE"],
    //                   onChanged: (value) {
    //                     updateProfileController.gender.value = value;
    //                   },
    //                 ),
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- EMAIL ----------
    //               // CustomInputField(
    //               //   readOnly: true,
    //               //   label: "Email *",
    //               //   hint: "Enter your Email",
    //               //   controller: updateProfileController.emailController,
    //               //   keyboardType: TextInputType.emailAddress,
    //               //   validator: AppValidator.validateNotEmpty,
    //               // ),
    //               // SizedBox(height: 20.h),

    //               /// ---------- DOB ----------
    //               GestureDetector(
    //                 onTap: () async {
    //                   DateTime? picked = await showDatePicker(
    //                     context: context,
    //                     firstDate: DateTime(1950),
    //                     lastDate: DateTime.now(),
    //                     initialDate: DateTime(2000),
    //                   );
    //                   if (picked != null) {
    //                     updateProfileController.dobController.text = DateFormat(
    //                       "yyyy-MM-dd",
    //                     ).format(picked);
    //                   }
    //                 },
    //                 child: AbsorbPointer(
    //                   child: CustomInputField(
    //                     label: "Date of Birth *",
    //                     hint: "Select your DOB",
    //                     controller: updateProfileController.dobController,
    //                     validator: AppValidator.validateNotEmptyWithAll,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- ADDRESS ----------
    //               CustomInputField(
    //                 label: "Address *",
    //                 hint: "Bung Tomo St. 067",
    //                 controller: updateProfileController.addressController,
    //                 validator: AppValidator.validateNotEmpty,
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- OCCUPATION ----------
    //               CustomInputField(
    //                 label: "Occupation *",
    //                 hint: "UI/UX Designer",
    //                 controller: updateProfileController.occupationController,
    //                 validator: AppValidator.validateNotEmpty,
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- DESCRIPTION ----------
    //               CustomInputField(
    //                 label: "Description *",
    //                 hint: "Write about yourself",
    //                 controller: updateProfileController.descriptionController,
    //                 validator: AppValidator.validateNotEmptyWithAll,
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- EDUCATION ----------
    //               CustomInputField(
    //                 label: "Education *",
    //                 hint: "M.Sc in CSE",
    //                 controller: updateProfileController.educationController,
    //                 validator: AppValidator.validateNotEmpty,
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- EXPERIENCE ----------
    //               // CustomInputField(
    //               //   label: "Job Experience *",
    //               //   hint: "1 Year",
    //               //   controller: updateProfileController.experienceController,
    //               //   validator: AppValidator.validateNotEmpty,
    //               // ),
    //               Obx(
    //                 () => CustomDropdownField(
    //                   label: "Job Experience *",
    //                   hintText: "Select Experience Level",
    //                   items: updateProfileController.jobExperienceOptions,
    //                   selectedValue:
    //                       updateProfileController.jobExperienceType.value,
    //                   onChanged: updateProfileController.selectedJobExperience,
    //                 ),
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- PROFESSIONAL LANGUAGE ----------
    //               Obx(
    //                 () => CustomDropdownField(
    //                   label: "Languages (Professional) *",
    //                   hintText: "Select",
    //                   selectedValue:
    //                       updateProfileController.professionalLang.value,
    //                   items: const ["ENGLISH", "SPANISH"],
    //                   onChanged: (value) {
    //                     updateProfileController.professionalLang.value = value;
    //                   },
    //                 ),
    //               ),
    //               SizedBox(height: 20.h),

    //               /// ---------- NATIVE LANGUAGE ----------
    //               Obx(
    //                 () => CustomDropdownField(
    //                   label: "Languages (Native) *",
    //                   hintText: "Select",
    //                   selectedValue: updateProfileController.nativeLang.value,
    //                   items: const ["ENGLISH", "SPANISH"],
    //                   onChanged: (value) {
    //                     updateProfileController.nativeLang.value = value;
    //                     // updateProfileController.nativeLangController.text = value;
    //                   },
    //                 ),
    //               ),
    //               SizedBox(height: 19.h),

    //               CustomText(
    //                 text: "Upload Video",
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //               SizedBox(height: 10.h),

    //               Obx(() {
    //                 if (updateProfileController.isVideo.value) {
    //                   return GestureDetector(
    //                     onTap: () {
    //                       log("upload video");
    //                       updateProfileController.pickVideo();
    //                     },
    //                     child: Container(
    //                       padding: const EdgeInsets.all(12),
    //                       decoration: BoxDecoration(
    //                         border: Border.all(
    //                           color: AppColors.textFormFieldBorder,
    //                         ),
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       child: Stack(
    //                         children: [
    //                           // 📄 Video path text
    //                           Padding(
    //                             padding: const EdgeInsets.only(right: 32),
    //                             child: CustomText(
    //                               text:
    //                                   "📸 You have already upload a Video For change this tap here!",
    //                               maxLines: 2,
    //                               color: AppColors.greenPrimary,
    //                             ),
    //                           ),

    //                           // Positioned(
    //                           //   top: 0,
    //                           //   right: 0,
    //                           //   child: InkWell(
    //                           //     onTap: () {
    //                           //       updateProfileController.videoPath.value =
    //                           //           null;
    //                           //     },
    //                           //     child: Container(
    //                           //       padding: const EdgeInsets.all(4),
    //                           //       decoration: BoxDecoration(
    //                           //         color: AppColors.primary.withOpacity(0.1),
    //                           //         shape: BoxShape.circle,
    //                           //       ),
    //                           //       child: const Icon(Icons.close, size: 16),
    //                           //     ),
    //                           //   ),
    //                           // ),
    //                         ],
    //                       ),
    //                     ),
    //                   );
    //                 }
    //                 if (updateProfileController.videoPath.value != null) {
    //                   return Container(
    //                     padding: const EdgeInsets.all(8),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: AppColors.textFormFieldBorder,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     child: Stack(
    //                       children: [
    //                         // 📄 Video path text
    //                         Padding(
    //                           padding: const EdgeInsets.only(right: 32),
    //                           child: CustomText(
    //                             text: updateProfileController
    //                                 .videoPath
    //                                 .value!
    //                                 .path,
    //                             maxLines: 2,
    //                           ),
    //                         ),

    //                         Positioned(
    //                           top: 0,
    //                           right: 0,
    //                           child: InkWell(
    //                             onTap: () {
    //                               updateProfileController.videoPath.value =
    //                                   null;
    //                             },
    //                             child: Container(
    //                               padding: const EdgeInsets.all(4),
    //                               decoration: BoxDecoration(
    //                                 color: AppColors.primary.withOpacity(0.1),
    //                                 shape: BoxShape.circle,
    //                               ),
    //                               child: const Icon(Icons.close, size: 16),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 }
    //                 return GestureDetector(
    //                   onTap: () {
    //                     log("upload video");
    //                     updateProfileController.pickVideo();
    //                   },
    //                   child: Container(
    //                     padding: EdgeInsets.only(
    //                       top: 36.h,
    //                       bottom: 36.h,
    //                       left: 16.w,
    //                       right: 16.w,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: AppColors.textFormFieldBorder,
    //                       ),
    //                       borderRadius: BorderRadius.circular(16),
    //                     ),
    //                     child: Center(
    //                       child: CustomText(
    //                         text: "Upload your video",
    //                         fontSize: 14.sp,
    //                         fontWeight: FontWeight.w400,
    //                         color: AppColors.grey4,
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }),

    //               SizedBox(height: 20.h),

    //               /// ---------- UPLOAD CV ----------
    //               CustomText(
    //                 text: 'Upload CV',
    //                 color: AppColors.textPrimary,
    //                 fontSize: 14.sp,
    //               ),
    //               SizedBox(height: 8.h),

    //               /// Resume picker
    //               ResumeUploadCard(),
    //               SizedBox(height: 20.h),

    //               /// Show selected file immediately
    //               Obx(() {
    //                 if (updateProfileController.isCv.value) {
    //                   return Container(
    //                     padding: const EdgeInsets.all(8),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: AppColors.textFormFieldBorder,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     child: Stack(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(right: 32),
    //                           child: CustomText(
    //                             text:
    //                                 "🗃️ You are already select a cv for change tap choose File!",
    //                             maxLines: 2,
    //                             color: AppColors.greenPrimary,
    //                           ),
    //                         ),

    //                         // Positioned(
    //                         //   top: 0,
    //                         //   right: 0,
    //                         //   child: InkWell(
    //                         //     onTap: () {
    //                         //       updateProfileController.videoPath.value =
    //                         //           null;
    //                         //     },
    //                         //     child: Container(
    //                         //       padding: const EdgeInsets.all(4),
    //                         //       decoration: BoxDecoration(
    //                         //         color: AppColors.primary.withOpacity(0.1),
    //                         //         shape: BoxShape.circle,
    //                         //       ),
    //                         //       child: const Icon(Icons.close, size: 16),
    //                         //     ),
    //                         //   ),
    //                         // ),
    //                       ],
    //                     ),
    //                   );
    //                 }
    //                 if (updateProfileController.selectedFile.value != null) {
    //                   return UploadedFileCard(
    //                     fileName: updateProfileController.selectedFileName,
    //                     fileSize: updateProfileController.selectedFileSize,
    //                     fileDate: '',
    //                     onRemove: () {
    //                       updateProfileController.deleteFile();
    //                     },
    //                   );
    //                 } else {
    //                   return const SizedBox();
    //                 }
    //               }),
    //               SizedBox(height: 20.h),

    //               /// ---------- SAVE BUTTON ----------
    //               Obx(() {
    //                 return CustomButton(
    //                   borderRadius: 16,
    //                   text: updateProfileController.isUpdatingProfile.value
    //                       ? "Saving..."
    //                       : "Save Changes",
    //                   // onPressed: updateProfileController.isUpdatingProfile.value
    //                   //     ? null
    //                   //     : () {
    //                   //         updateProfileController.updateProfile();
    //                   //       },
    //                   onPressed: () {
    //                     if (_formKey.currentState!.validate()) {
    //                       log("Validate");
    //                       updateProfileController.updateProfile();
    //                     }
    //                   },
    //                 );
    //               }),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: CustomAppBar(title: "Edit profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.currentIndex.value == 0) {
              return Padding(
                padding: EdgeInsets.all(getHeight(16)),
                child: JobSeekerPersonalInfo(controller: controller),
              );
            }
            if (controller.currentIndex.value == 1) {
              return Padding(
                padding: EdgeInsets.all(getHeight(2)),
                child: IntroVideoAndLocation(controllerForClient: controller),
              );
            }
            return Padding(
              padding: EdgeInsets.all(getHeight(2)),
              child: CvAndOthersInfo(controllerForClient: controller),
            );
          }),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getHeight(16)),
          child: Obx(
            () => Row(
              children: [
                if (controller.currentIndex.value > 0) ...[
                  Expanded(
                    child: CustomOutlineButton(
                      text: "Back",
                      onPressed: () {
                        log("Back");
                        controller.back();
                      },
                      borderColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: getWidth(20)),
                ],

                Expanded(
                  child: CustomSubmitButton(
                    text: controller.currentIndex.value == 2
                        ? "Complete"
                        : "Next",
                    onTap: () {
                      log("Next or completed");
                      controller.next();
                    },
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
