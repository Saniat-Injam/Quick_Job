import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/resume_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/resume_upload_card.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/uploaded_file_card.dart';

class ResumeUploadScreen extends StatelessWidget {
  final String userRole;

  const ResumeUploadScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final ResumeController controller = Get.put(ResumeController());
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Job Details",
                backgroundColor: AppColors.transparent,
              ),
              SizedBox(height: 40.h),
              Text(
                'Upload Resume',
                style: getTextStyle(
                  color: AppColors.blackSecondary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Please take a photo or upload your resume',
                style: getTextStyle(
                  color: AppColors.black4,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              ResumeUploadCard(),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.selectedFile.value != null) {
                  return UploadedFileCard(
                    fileName: controller.selectedFileName,
                    fileSize: controller.selectedFileSize,
                    fileDate: '',
                    onRemove: () {
                      controller.deleteFile();
                    },
                  );
                } else {
                  return Container();
                }
              }),

              const SizedBox(height: 40),
              CustomButton(
                onPressed: controller.resumeUpload,
                text: 'Upload Resume',
                style: getTextStyle(
                  color: AppColors.whitePrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 40.h),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.whitePrimary,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Privacy Note: ',
                  style: getTextStyle(
                    color: AppColors.black3,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text:
                      'Your resume is private — used only for matching and never shared.',
                  style: getTextStyle(
                    color: AppColors.black4,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
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
