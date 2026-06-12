import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/application/models/job_application_model.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/screens/pending_job_details_screen.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/screens/rejected_job_details_screen.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/screens/scheduled_for_interview_screen.dart';

// --- FIX: Restored toTitleCase for correct navigation matching ---
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.toCapitalized()).join(' ');
}
// ----------------------------------------------------------------

class JobCard extends StatelessWidget {
  final JobApplicationModel application;
  const JobCard({super.key, required this.application});
  String get standardStatus => application.status.toUpperCase();

  Color getStatusColor() {
    switch (standardStatus) {
      case 'PENDING':
        return Color(0xFFD88900);
      case 'REJECT':
        return Color(0xFFD32F2F);
      case 'ACCEPT':
        return Color(0xFF0E55FD);
      case 'INTERVIEW':
        return Color(0xFF0E55FD);
      default:
        return Colors.grey;
    }
  }

  Color getStatusBg() {
    switch (standardStatus) {
      case 'PENDING':
        return Color(0xFFFFE9C2);
      case 'REJECT':
        return Color(0xFFFFDEDA);
      case 'ACCEPT':
        return Color(0xFFDFEFFF);
      case 'INTERVIEW':
        return Color(0xFFDFEFFF);
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayStatus = standardStatus.replaceAll('_', ' ').toTitleCase();
    final buttonText = standardStatus == 'ACCEPT'
        ? "Schedule for Interview"
        : displayStatus;

    return InkWell(
      onTap: () {
        switch (displayStatus) {
          case 'Pending':
            Get.to(() => PendingJobDetailsScreen(application: application));
            break;
          case 'Reject':
            Get.to(() => RejectedJobDetailsScreen(application: application));
            break;
          case 'Accept':
            Get.to(() => ScheduledForInterviewScreen(application: application));
            break;
          case 'Scheduled For Interview':
            Get.to(() => ScheduledForInterviewScreen(application: application));
            break;
          default:
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  application.logoUrl,
                  width: 64.w,
                  height: 64.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.work_outline,
                      size: 32.w,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.jobPost.position,
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        application.jobPost.employerProfile.companyName,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: Color(0xFFE0E0E0), thickness: 1.h),
            SizedBox(height: 16.h),
            CustomButton(
              text: buttonText,
              style: getTextStyle(
                color: getStatusColor(),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
              buttonColor: getStatusBg(),
              borderRadius: 60,
              height: 37,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
