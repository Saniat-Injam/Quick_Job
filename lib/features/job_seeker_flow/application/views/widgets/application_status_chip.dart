import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class ApplicationStatusChip extends StatelessWidget {
  final String status;

  const ApplicationStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE9C2),
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: Text(
        status,
        style: getTextStyle(
          color: const Color(0xFFD88900),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
