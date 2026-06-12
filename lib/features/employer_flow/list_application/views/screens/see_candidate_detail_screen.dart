import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/see_candidate_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/application_screen.dart';

class SeeCandidateDetail extends StatelessWidget {
  final Map<String, dynamic> applicant;

  SeeCandidateDetail({super.key, required this.applicant});

  final controller = Get.find<SeeCandidateController>();

  @override
  Widget build(BuildContext context) {
    // Safely extract required data
    final jobSeekerProfile =
        applicant['job_seekers_profile'] as Map<String, dynamic>? ?? {};
    final userProfile = jobSeekerProfile['user'] as Map<String, dynamic>? ?? {};

    final String fullName =
        userProfile['fullName'] as String? ??
        applicant['fullName'] as String? ??
        'No Name';
    final String? profileImage =
        userProfile['profileImage'] as String? ??
        applicant['profileImage'] as String?;
    final String position =
        applicant['position'] as String? ?? 'Unknown Position';
    final String resumeUrl = applicant['resumeUrl'] as String? ?? '';
    final String jobApplyId = applicant['id'] as String? ?? '';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 36.0.h, left: 10.0.w, right: 10.0.w),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: "Candidate Details",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32.h,
                  backgroundImage:
                      profileImage != null && profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                ),
                SizedBox(height: 12.h),
                CustomText(
                  text: fullName,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackPrimary,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  text: "Active 35 min ago",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackPrimary,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _contianrIcon(iconPath: IconPath.audioCall),
                    SizedBox(width: 16.h),
                    _contianrIcon(iconPath: IconPath.videoCall),
                    SizedBox(width: 16.h),
                    _contianrIcon(iconPath: IconPath.shear),
                  ],
                ),
                SizedBox(height: 24.h),
                CustomSubmitButton(
                  text: "💬 Chat with $fullName",
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.bluePrimary,
                ),
                SizedBox(height: 24.h),
                _iconText(
                  iconPath: IconPath.nearbyJobCardLocation,
                  text: applicant['address'] ?? "Unknown Location",
                ),
                SizedBox(height: 24.h),
                Divider(color: AppColors.textFormFieldBorder),
                SizedBox(height: 24.h),

                _sectionTitle("Description"),
                _sectionText(
                  applicant['description'] ?? "No description available.",
                ),

                SizedBox(height: 24.h),
                Divider(color: AppColors.textFormFieldBorder),
                SizedBox(height: 24.h),

                _sectionTitle("Experience"),
                _sectionText(
                  applicant['experience'] ?? "No experience listed.",
                ),

                SizedBox(height: 24.h),
                Divider(color: AppColors.textFormFieldBorder),
                SizedBox(height: 24.h),
                _sectionTitle("Languages"),
                _sectionText(
                  "Professional: ${applicant['languageProfessional'] ?? 'Not specified'}",
                ),
                _sectionText(
                  "Native: ${applicant['languageNative'] ?? 'Not specified'}",
                ),

                SizedBox(height: 24.h),

                _sectionTitle("Education"),
                _sectionText(applicant['education'] ?? "No education listed."),

                SizedBox(height: 24.h),
                Divider(color: AppColors.textFormFieldBorder),
              ],
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
          text: "Send Feedback",
          onTap: () {
            // FIX: Pass required data to ApplicationScreen
            Get.to(
              () => ApplicationScreen(
                candidateName: fullName,
                candidatePosition: position,
                candidateImage: profileImage ?? '',
                resumeUrl: resumeUrl,
                jobApplyId: jobApplyId,
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bluePrimary,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => SizedBox(
    width: double.infinity,
    child: CustomText(
      text: title,
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      textAlign: TextAlign.left,
    ),
  );

  Widget _sectionText(String text) => Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: SizedBox(
      width: double.infinity,
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        textAlign: TextAlign.left,
      ),
    ),
  );
}

Widget _iconText({required String text, required String iconPath}) {
  return Row(
    children: [
      SvgPicture.asset(
        iconPath,
        height: 18.h,
        width: 18.w,
        fit: BoxFit.contain,
        color: AppColors.textSecondary,
      ),
      SizedBox(width: 8.w),
      CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    ],
  );
}

Widget _contianrIcon({required String iconPath}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: AppColors.containerBgColor,
      shape: BoxShape.circle,
    ),
    child: SvgPicture.asset(
      iconPath,
      height: 24.h,
      width: 24.w,
      fit: BoxFit.contain,
      color: AppColors.blackPrimary,
    ),
  );
}
