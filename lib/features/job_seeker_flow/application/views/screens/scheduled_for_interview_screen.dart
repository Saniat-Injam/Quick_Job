import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/application/controller/job_application_controller.dart';
import 'package:quick_job/features/job_seeker_flow/application/models/job_application_model.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/widgets/job_card.dart';

import '../../../../../core/utils/constants/app_colors.dart';

class ScheduledForInterviewScreen extends StatelessWidget {
  final JobApplicationModel application;
  final JobApplicationController jobApplicationController = Get.find();

  ScheduledForInterviewScreen({super.key, required this.application});

  // String _formatInterviewDate(String? dateString) {
  //   if (dateString == null || dateString.isEmpty) return "Date not set";
  //   try {
  //     final date = DateTime.parse(dateString);
  //     return DateFormat('EEEE, MMM d, yyyy').format(date);
  //   } catch (e) {
  //     return "Date format error";
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final jobPost = application.jobPost;
    // final interviewDate = application.InterviewDate;
    // final interviewTime = application.InterViewTime;
    final message =
        application.message ??
        "Congratulations! Your application has been accepted for an interview.";

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Interview Scheduled",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF424242),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobCard(application: application),
            SizedBox(height: 8.h),

            Text(
              "Job Details:",
              style: getTextStyle(
                color: const Color(0xFF1F2937),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),

            _buildInfoCard("Salary", '\$${jobPost.salary.toString()}'),
            SizedBox(height: 8.h),
            _buildInfoCard("Job Type", jobPost.jobType),
            SizedBox(height: 8.h),
            _buildInfoCard("Location", jobPost.location),
            SizedBox(height: 8.h),
            _buildInfoCard(
              "Date",
              DateFormat(
                "dd/MM/yyyy",
              ).format(application.InterviewDate ?? DateTime.now()),
            ),
            SizedBox(height: 8.h),
            _buildInfoCard("Time", application.InterViewTime ?? "NA"),
            SizedBox(height: 8.h),
            Text(
              "Message*",
              style: getTextStyle(
                color: const Color(0xFF1F2937),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.whitePrimary,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFDFEFFF)),
              ),
              child: Text(
                message,
                style: getTextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFF0E55FD),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              "Back",
              style: getTextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getTextStyle(
              fontSize: 16.sp,
              color: AppColors.black4,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.bluePrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
