import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/job_details_controller.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/screens/apply_job_screen.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/widgets/job_requirement_item.dart';
import '../../../job_seeker_home/models/nearby_job_model.dart';

class JobDetailsScreen extends GetView<JobDetailsController> {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final job = Get.arguments as NearbyJobModel;
    final controller = Get.isRegistered<JobDetailsController>()
        ? Get.find<JobDetailsController>()
        : Get.put(JobDetailsController());
    controller.job.value = job;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Job Details",
                backgroundColor: AppColors.transparent,
              ),
              const SizedBox(height: 24),
              Obx(() {
                final job = controller.job.value;
                final bool isNetworkImage = job.profileImage.isNotEmpty && job.profileImage.startsWith('http');

                Widget companyLogoWidget;

                if (isNetworkImage) {
                  companyLogoWidget = Image.network(
                    job.profileImage,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business_center, size: 40.w, color: AppColors.textGrey);
                    },
                  );
                } else {
                  companyLogoWidget = (job.profileImage.isNotEmpty)
                      ? Image.asset(
                    job.profileImage,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business_center, size: 40.w, color: AppColors.textGrey);
                    },
                  )
                      : Icon(Icons.business_center, size: 40.w, color: AppColors.textGrey);
                }

                final sizedLogo = SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: companyLogoWidget,
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x288E8DD0),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          sizedLogo,
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title,
                                  style: getTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  job.company,
                                  style: getTextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.black4,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(
                          "Salary",
                          job.salary,
                        ),
                        SizedBox(height: 8.h,),
                        _buildInfoCard(
                          "Job Type",
                          job.jobType,
                        ),
                        SizedBox(height: 8.h,),

                        _buildInfoCard(
                          "Location",
                          job.location,
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      "Requirements",
                      style: getTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      children: job.requirements
                          .map((req) => JobRequirementItem(text: req))
                          .toList(),
                    ),
                    SizedBox(height: 40.h),
                    CustomButton(
                      text: "Apply Now",
                      onPressed: () {
                        Get.to(
                              () => ApplyJobScreen(),
                          arguments: {
                            'jobPostId': job.id,
                            'title':
                            controller.job.value.title,
                            'company':
                            controller.job.value.company,
                            'profileImage': controller.job.value.profileImage,


                          },
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
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
            color: Colors.grey.withValues(alpha: 0.1),
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
            style: getTextStyle(fontSize: 16.sp, color: AppColors.black4,fontWeight: FontWeight.w400),
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