import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/models/job_model.dart';

class JobInfoSection extends StatelessWidget {
  final JobModel job;
  const JobInfoSection({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.greyPrimary),
        infoRow('Salary', job.salaryRange),
        infoRow('Type', job.type),
        infoRow('Location', job.location),
        const Divider(color: AppColors.greyPrimary),
      ],
    );
  }

  Widget infoRow(String label, String value) => Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black5,
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.bluePrimary,
          ),
        ),
      ],
    ),
  );
}
