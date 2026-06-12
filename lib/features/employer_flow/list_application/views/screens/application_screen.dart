import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/aplication_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/aplication_two_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/edit_job_post_detail_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/see_resume_screen.dart';

class ApplicationScreen extends StatelessWidget {
  ApplicationScreen({
    super.key,
    required this.candidateName,
    required this.candidatePosition,
    required this.candidateImage,
    required this.resumeUrl,
    required this.jobApplyId,
  });

  final String candidateName;
  final String candidatePosition;
  final String candidateImage;
  final String resumeUrl;
  final String jobApplyId;

  final controller = Get.find<AplicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 36.0.h, left: 10.0.w, right: 10.0.w),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: "Applicants",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Container(
              padding: EdgeInsets.all(16.0.h),
              decoration: BoxDecoration(
                color: AppColors.whitePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: candidateImage.isNotEmpty
                          ? NetworkImage(candidateImage) as ImageProvider
                          : AssetImage(ImagePath.albertFlores) as ImageProvider,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: candidateName,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        CustomText(
                          text: candidatePosition,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.textFormFieldBorder),
                  SizedBox(height: 16.h),
                  CustomSubmitButton(
                    text: "See Resume",
                    onTap: () {
                      if (resumeUrl.isNotEmpty) {
                        Get.to(() => SeeResumeScreen(pdfUrl: resumeUrl));
                      } else {
                        Get.snackbar(
                          'Info',
                          'Resume not available for this candidate.',
                        );
                      }
                    },
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => CustomDropdownField(
                      hintText: "Mark Status as",
                      items: controller.statusList,
                      selectedValue: controller.seletedStatus.value,
                      onChanged: controller.troggleStatus,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.textFormFieldBorder),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: requeidRichTect(text: "Message"),
                  ),
                  CustomTextFormField(
                    controller: controller.messageController,
                    hintText: "Message",
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          top: 20.0.h,
          left: 16.w,
          right: 16.w,
          bottom: 34.h,
        ),
        child: CustomSubmitButton(
          text: controller.isSubmitting.value ? "Loading..." : "Next",
          onTap: () {
            if (controller.seletedStatus.value.isEmpty) {
              AppSnackBar.showError("Please select a status");
              return;
            }

            if (controller.seletedStatus.value.toLowerCase() == "interview") {
              
              Get.to(
                () => AplicationTwoScreen(
                  candidateName: candidateName,
                  candidatePosition: candidatePosition,
                  candidateImage: candidateImage,
                  resumeUrl: resumeUrl,
                  jobApplyId: jobApplyId,
                ),
              );
            } else {
              controller
                  .submitApplicationStatus(
                    jobApplyId: jobApplyId,
                    status: 'REJECT',
                    message: controller.messageController.text,
                  )
                  .then((success) {
                    if (success) {
                      // Get.to(() => EditJobPostDetailScreen());
                      Get.back();
                      AppSnackBar.showSuccess("Successfully reject this user.");
                    } else {
                      AppSnackBar.showError(
                        "Failed to update application status",
                      );
                    }
                  });
            }
          },
          color: AppColors.bluePrimary,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
