import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/application/controller/job_application_controller.dart';
import 'package:quick_job/features/job_seeker_flow/application/models/job_application_model.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/widgets/job_card.dart';

class PendingJobDetailsScreen extends StatelessWidget {
  final JobApplicationModel application;
  // final controller = Get.put(PendingDetailsController());
  final JobApplicationController jobApplicationController = Get.find();
  PendingJobDetailsScreen({super.key, required this.application});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Applications",
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ApplicationHeader(
            //   title: app.title,
            //   company: app.company,
            //   imageUrl: "https://placehold.co/64x64",
            // ),
            // SizedBox(height: 16.h),
            // ApplicationStatusChip(status: app.status),
            // Expanded(
            //   child: Obx(() {
            //     final apps = jobApplicationController.filteredApplications;
            //     return ListView.separated(
            //       itemCount: apps.length,
            //       separatorBuilder: (_, __) => SizedBox(height: 16.h),
            //       itemBuilder: (_, index) =>
            //           JobCard(application: apps[index]),
            //     );
            //   }),
            // ),
            JobCard(application: application),
            SizedBox(height: 24.h),
            // ApplicationInfoSection(
            //   salary: app.salaryRange,
            //   jobType: app.jobType,
            //   location: app.location,
            // ),
            // SizedBox(height: 24.h),
            // Text(
            //   "Waiting for review ...",
            //   style: getTextStyle(
            //     color: const Color(0xFF6B7280),
            //     fontSize: 16.sp,
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Opacity(
            opacity: 0.8,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.bluePrimary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                "Back",
                style: getTextStyle(
                  color: AppColors.textWhite,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
