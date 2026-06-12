import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
// Removed unnecessary LogoPath import
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/apply_job_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/resume_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/job_card.dart';
// UploadCVSection is not used, leaving ResumeUploadCard
// import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/upload_cv_section.dart';
// import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/uploaded_file_card.dart';

class ApplyJobScreen extends StatelessWidget {
  final controller = ApplyJobController();
  final resumeController = ResumeController();

  ApplyJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, String>;
    final jobPostId = arguments['jobPostId'] ?? 'default_job_id';
    final jobTitle = arguments['title'] ?? 'Unknown Position';
    final companyName = arguments.containsKey('company')
        ? arguments['company']!
        : 'Unknown Company';
    // --- FIX: Extract the profile image URL ---
    final imageUrl = arguments.containsKey('profileImage')
        ? arguments['profileImage']!
        : '';
    // --- END FIX ---
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: "Job Details",
                    backgroundColor: AppColors.transparent,
                  ),
                  SizedBox(height: 24.h),
                  JobCard(
                    jobTitle: jobTitle,
                    companyName: companyName,
                    imageUrl: imageUrl,
                    // --- END FIX ---
                  ),

                  // SizedBox(height: 24.h),
                  // CustomInputField(
                  //   label: "Full Name",
                  //   hint: "Enter your Name",
                  //   onChanged: (v) => controller.fullName.value = v,
                  //   validator: AppValidator.validateNotEmpty,
                  // ),
                  // SizedBox(height: 16.h),

                  // CustomInputField(
                  //   label: "Phone Number",
                  //   hint: "Enter your Number",
                  //   keyboardType: TextInputType.phone,
                  //   onChanged: (v) => controller.phoneNumber.value = v,
                  //   validator: AppValidator.validateNotEmpty,
                  // ),
                  // SizedBox(height: 16.h),
                  // CustomInputField(
                  //   label: "Email Address",
                  //   hint: "Enter your Email Address",
                  //   keyboardType: TextInputType.emailAddress,
                  //   onChanged: (v) => controller.email.value = v,
                  //   validator: AppValidator.validateEmail,
                  // ),
                  // SizedBox(height: 24.h),
                  // ResumeUploadCard(), // UploadCVSection(onUploadTap: controller.uploadCV),
                  // SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getHeight(20)),
          child: Obx(
            () => CustomButton(
              text: controller.isLoading.value ? "Applying..." : "Apply Now",
              onPressed: () {
                controller.applyForJob(jobPostId);
              },
              buttonColor: controller.isFileUploaded.value
                  ? AppColors.bluePrimary
                  : AppColors.bluePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
