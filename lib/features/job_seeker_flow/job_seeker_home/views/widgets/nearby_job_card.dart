import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/models/nearby_job_model.dart';

class NearbyJobCard extends StatelessWidget {
  final NearbyJobModel job;
  final VoidCallback onApply;
  final VoidCallback onChat;

  const NearbyJobCard({
    super.key,
    required this.job,
    required this.onApply,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundImage: (job.profileImage.startsWith('http'))
                    ? NetworkImage(job.profileImage)
                    : null,
                child: (!job.profileImage.startsWith('http'))
                    ? Icon(
                        Icons.business_center,
                        size: 24.w,
                        color: AppColors.textGrey,
                      )
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.company,
                      style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          job.salary,
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bluePrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12.sp,
                          color: AppColors.textGrey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          job.location,
                          style: getTextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Apply',
                  onPressed: onApply,
                  borderRadius: 16,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: CustomOutlineButton(text: 'Chat now', onPressed: onChat),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
