import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/job_seeker_flow/application/controller/job_application_controller.dart';

class FilterChips extends StatelessWidget {
  final JobApplicationController controller;
  final List<String> filters;
  const FilterChips({
    super.key,
    required this.controller,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: filters.map((filter) {
          final isSelected = controller.selectedFilter.value == filter;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: () => controller.selectFilter(filter),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF0E55FD) : Colors.transparent,
                    borderRadius: BorderRadius.circular(99.r),
                    border: Border.all(color: Color(0xFF0E55FD), width: 1.w),
                  ),
                  child: Center(
                    child: Text(
                      filter,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Color(0xFF0E55FD),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
