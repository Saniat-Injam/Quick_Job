import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/application/controller/job_application_controller.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/widgets/filter_chips.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/widgets/job_card.dart';

TextStyle getTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}

class JobApplicationsScreen extends StatelessWidget {
  final JobApplicationController jobApplicationController = Get.find();
  final filters = [
    'ACCEPT', 'PENDING', 'REJECT',
    // 'INTERVIEW'
  ];

  JobApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomAppBar(
                title: "Applications",
                backgroundColor: Colors.transparent,
                spacing: 0.h,
              ),
              // SizedBox(height: 20.h),

              // Search bar
              // CustomSearchBar(
              //   //controller: textController,
              //   //onChanged: controller.searchJob,
              // ),
              SizedBox(height: 24.h),
              FilterChips(
                controller: jobApplicationController,
                filters: filters,
              ),
              SizedBox(height: 24.h),

              Expanded(
                child: Obx(() {
                  final controller = jobApplicationController;
                  final apps = controller.filteredApplications;

                  if (controller.isLoading.value && apps.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (apps.isEmpty && !controller.isLoading.value) {
                    return Center(
                      child: CustomText(
                        text: "No applications found.",
                        fontSize: 14.sp,
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  int totalItems = apps.length;
                  if (controller.hasMoreData.value ||
                      controller.isLoading.value) {
                    totalItems += 1;
                  }
                  return ListView.separated(
                    itemCount: totalItems,
                    separatorBuilder: (_, _) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      if (index == apps.length) {
                        if (controller.hasMoreData.value &&
                            !controller.isLoading.value) {
                          controller.fetchApplications();
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return JobCard(application: apps[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
