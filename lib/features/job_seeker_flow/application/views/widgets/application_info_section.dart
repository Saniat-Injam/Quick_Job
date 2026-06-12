import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class ApplicationInfoSection extends StatelessWidget {
  final int salary;
  final String jobType;
  final String location;

  const ApplicationInfoSection({
    super.key,
    required this.salary,
    required this.jobType,
    required this.location,
  });

  Widget _buildDetailRow({required String label, required String value, required IconData icon}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.w, color: const Color(0xFF6B7280)),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: getTextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: getTextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  String get formattedSalary {
    return '\$${salary.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            label: "Salary Estimate",
            value: formattedSalary,
            icon: Icons.attach_money,
          ),
          Divider(color: const Color(0xFFE0E0E0), height: 1.h),
          _buildDetailRow(
            label: "Job Type",
            value: jobType.replaceAll('_', ' '),
            icon: Icons.access_time_filled,
          ),
          Divider(color: const Color(0xFFE0E0E0), height: 1.h),
          _buildDetailRow(
            label: "Location",
            value: location,
            icon: Icons.location_on,
          ),
        ],
      ),
    );
  }
}