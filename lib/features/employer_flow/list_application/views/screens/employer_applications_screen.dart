import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/employer_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/employer_aplication_detail_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/create_job_post_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/edit_job_post_detail_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/widget/bottom_sheet_sction.dart';

import '../../../../profile_flow/profile_home/controllers/profile_controller.dart';

class EmployerApplicationsScreen extends StatelessWidget {
  EmployerApplicationsScreen({super.key});

  final controller = Get.find<EmployerController>();

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Obx(
                () => CustomAppBar(
                  padding: EdgeInsets.zero,
                  title: profileController.userName.value,
                  textStyle: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                  backgroundColor: Colors.transparent,
                  leadingImagePath: profileController.profileImage.value,
                  trailingIconPath: IconPath.add,
                  onTrailingTap: () => Get.to(() => CreateJobPostScreen()),
                ),
              ),
              // SizedBox(height: 24.h),

              // // Search Field
              // CustomTextFormField(
              //   controller: controller.searchController,
              //   hintText: "Search...",
              //   containerBorderWidth: 1,
              //   onChanged: (value) => controller.searchJobs(value),
              //   suffixIcon: IconButton(
              //     onPressed: () {
              //       controller.searchController.clear();
              //       controller.searchJobs('');
              //     },
              //     icon: Icon(Icons.search),
              //   ),
              // ),
              SizedBox(height: 24.h),

              // Category Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryTap(text: "All Vacancies", controller: controller),
                    SizedBox(width: 8.w),
                    categoryTap(text: "Active", controller: controller),
                    SizedBox(width: 8.w),
                    categoryTap(text: "Inactive", controller: controller),
                    // SizedBox(width: 8.w),
                    // categoryTap(text: "Pause", controller: controller),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.bluePrimary,
                      ),
                    );
                  }

                  final jobs = controller.filteredJobList;

                  if (jobs.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No Job Found!",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    itemCount:
                        jobs.length +
                        (controller.isPaginationLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == jobs.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.bluePrimary,
                            ),
                          ),
                        );
                      }

                      final data = jobs[index];
                      final requirements = data['requirements'] is List
                          ? List<String>.from(data['requirements'])
                          : <String>[];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            BottomSheetAction.show(
                              onEdit: () {
                                Get.back();
                                Get.to(
                                  () => EditJobPostDetailScreen(jobData: data),
                                );
                              },
                              onDetail: () {
                                Get.back();
                                Get.to(
                                  () => EmployerAplicationDetailScreen(
                                    status: data['status'] ?? 'N/A',
                                    position: data['position'] ?? 'N/A',
                                    company: data['companyName'] ?? 'N/A',
                                    location: data['location'] ?? 'N/A',
                                    salary: data['salary'] ?? 0,
                                    jobId: data['id'] ?? 'N/A',
                                    requirements: requirements,
                                  ),
                                );
                              },
                              onDelete: () {
                                log("delete job ${data['id'] ?? ""}");
                                Get.back();
                                Future.microtask(() async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 200),
                                  );
                                  if (Get.isDialogOpen == false) {
                                    controller.deleteJobPost(
                                      id: data['id'] ?? "",
                                    );
                                  }
                                });
                              },
                              onPause: () {
                                // Optional: add pause logic
                              },
                            );
                          },
                          child: jobCard(
                            id: data['id'] ?? 'Unknown ID',
                            position: (data['position'] ?? 'Unknown Position')
                                .toString(),
                            company: (data['companyName'] ?? 'Company')
                                .toString(),
                            location: (data['location'] ?? 'Location')
                                .toString(),
                            salary: (data['salary'] ?? 0) as int,
                            status: (data['status'] ?? 'Active').toString(),
                            requirements: requirements,
                          ),
                        ),
                      );
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

// Job Card Widget
Widget jobCard({
  required String id,
  required String position,
  required String company,
  required String location,
  required int salary,
  required String status,
  required List<String> requirements,
}) {
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          ImagePath.uiUxDesigner,
          height: 64.h,
          width: 64.w,
          fit: BoxFit.contain,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: position,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  maxLines: 1,
                ),
                CustomText(
                  text: company,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  maxLines: 1,
                ),
                CustomText(
                  text: "$location - Full Time",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: status == "Active"
                    ? AppColors.activeBgColor
                    : AppColors.inActiveBgColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: CustomText(
                text: status,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: status == "Active"
                    ? AppColors.activeColor
                    : AppColors.inActiveColor,
              ),
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "\$${salary ~/ 1000}K",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bluePrimary,
            ),
          ],
        ),
      ],
    ),
  );
}

// Category Tap Widget
Widget categoryTap({
  required String text,
  required EmployerController controller,
}) {
  return Obx(() {
    final isSelected = controller.selectedCategory.value == text;

    return GestureDetector(
      onTap: () => controller.toggleSelection(text),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.bluePrimary : Colors.transparent,
          border: Border.all(color: AppColors.bluePrimary, width: 1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.whitePrimary : AppColors.bluePrimary,
          ),
        ),
      ),
    );
  });
}
