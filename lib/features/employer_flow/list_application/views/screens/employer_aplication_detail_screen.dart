import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/aplication_detail_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/see_candidate_detail_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/see_resume_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/application_screen.dart';

class EmployerAplicationDetailScreen extends StatefulWidget {
  const EmployerAplicationDetailScreen({
    super.key,
    required this.jobId,
    this.status = 'Active',
    this.position = 'Position',
    this.company = 'Company',
    this.location = 'Location',
    this.salary = 0,
    this.requirements = const [],
  });

  final String jobId;
  final String status;
  final String position;
  final String company;
  final String location;
  final int salary;
  final List<String> requirements;

  @override
  State<EmployerAplicationDetailScreen> createState() =>
      _AplicationDetailScreenState();
}

class _AplicationDetailScreenState
    extends State<EmployerAplicationDetailScreen> {
  late AplicationDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AplicationDetailController());
    controller.fetchJobDetails(widget.jobId);
    controller.fetchApplicants(widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 36.0.h, left: 10.0.w, right: 10.0.w),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: "Application Details",
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: Column(
                    children: [
                      Obx(() => _buildJobCard()),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text:
                                "Applicants (${controller.applicants.length})",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     print("See all applicants");
                          //   },
                          //   child: CustomText(
                          //     text: "See all",
                          //     fontSize: 14.sp,
                          //     fontWeight: FontWeight.w600,
                          //     color: AppColors.bluePrimary,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // See Resume Button
                      Expanded(
                        child: controller.isLoadingApplicants.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.applicants.isEmpty
                            ? Center(
                                child: CustomText(
                                  text: "No applicants yet",
                                  fontSize: 16.sp,
                                  color: AppColors.textSecondary,
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.applicants.length,
                                itemBuilder: (context, index) {
                                  final applicant =
                                      controller.applicants[index];
                                  final String resumeUrl =
                                      applicant['resumeUrl'] as String? ?? '';

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.0.h),
                                    child: _customCard(
                                      applicant: applicant,
                                      seeResum: () {
                                        if (resumeUrl.isNotEmpty) {
                                          Get.to(
                                            () => SeeResumeScreen(
                                              pdfUrl: resumeUrl,
                                            ),
                                          );
                                        } else {
                                          AppSnackBar.showError(
                                            "Resume not available for this candidate.",
                                          );
                                        }
                                      },
                                      seeDetail: () {
                                        log("I am here details");
                                        Get.to(
                                          () => SeeCandidateDetail(
                                            applicant: applicant,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildJobCard() {
    final jobDetailsMap = controller.jobDetails;
    final job = jobDetailsMap.isNotEmpty
        ? jobDetailsMap
        : <String, dynamic>{
            'position': widget.position,
            'location': widget.location,
            'salary': widget.salary,
            'jobPostStatus': widget.status,
            'requirements': widget.requirements,
          };
    final position = job['position'] as String? ?? 'Position';
    final status = job['jobPostStatus'] as String? ?? 'ACTIVE';
    final location = job['location'] as String? ?? 'Location';
    final salaryValue = job['salary'];
    final salaryText =
        (salaryValue is num
            ? salaryValue.toString()
            : salaryValue?.toString()) ??
        '0';

    return Container(
      padding: EdgeInsets.all(16.0.h),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadoColor,
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: position,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: widget.company,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  text: status.replaceAll('_', ' '),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(status),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: location,
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: "\$$salaryText",
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.bluePrimary,
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _customCard({
    required Map<String, dynamic> applicant,
    required VoidCallback seeResum,
    required VoidCallback seeDetail,
  }) {
    final String fullName =
        applicant['fullName'] as String? ?? 'Candidate Name';
    final String? profileImage = applicant['profileImage'] as String?;
    final bool hasProfileImage =
        profileImage != null && profileImage.isNotEmpty;
    final String resumeUrl = applicant['resumeUrl'] as String? ?? '';
    final String position = applicant['position'] as String? ?? 'Position';
    // FIX: Get the jobApplyId here
    final jobApplyId = applicant['id'] as String? ?? '';

    return Container(
      padding: EdgeInsets.all(12.0.h),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadoColor,
            offset: Offset(0, 0),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: hasProfileImage
                  ? NetworkImage(profileImage) as ImageProvider
                  : AssetImage(ImagePath.albertFlores) as ImageProvider,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: fullName,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                CustomText(
                  text: position,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Divider(color: AppColors.textFormFieldBorder, thickness: 1),
          SizedBox(height: 9.h),

          // See Resume Button
          Row(
            children: [
              Expanded(
                child: CustomSubmitButton(
                  text: "See Resume",
                  onTap: seeResum,
                  color: AppColors.bluePrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 16.w),

              // See Details Button
              Expanded(
                child: CustomOutlineButton(
                  text: "See Details",
                  onPressed: () {
                    log("I am hear inside");
                    Get.to(
                      () => ApplicationScreen(
                        candidateName: fullName,
                        candidatePosition: position,
                        candidateImage: profileImage ?? '',
                        resumeUrl: resumeUrl,
                        jobApplyId: jobApplyId, // Pass the ID
                      ),
                    );
                    //Get.to(SeeCandidateDetail(applicant: applicant));
                  },
                  borderColor: AppColors.bluePrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    final statusLower = status.toLowerCase();
    if (statusLower.contains('active')) {
      return Colors.green;
    } else if (statusLower.contains('closed')) {
      return Colors.red;
    } else if (statusLower.contains('draft') || statusLower.contains('pause')) {
      return Colors.orange;
    }
    return AppColors.bluePrimary;
  }
}
