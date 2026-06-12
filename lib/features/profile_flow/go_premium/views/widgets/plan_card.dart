import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/profile_flow/go_premium/models/plan_model.dart';

class PlanCard extends StatelessWidget {
  final AllPlan plan;
  final Color isSelectedColorForBg;
  final Color isSelectedColorForBorder;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.plan,
    required this.isSelectedColorForBg,
    required this.isSelectedColorForBorder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelectedColorForBg,
          border: Border.all(color: isSelectedColorForBorder, width: 2.w),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  (plan.price ?? 0).toStringAsFixed(2),
                  style: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                // Spacer(),
                // Radio(
                //   value: '',
                //   // ignore: deprecated_member_use
                //   groupValue: isSelected ? '' : null,
                //   // ignore: deprecated_member_use
                //   onChanged: (val) => onTap(),
                //   fillColor: WidgetStateProperty.all(AppColors.bluePrimary),
                // ),
              ],
            ),

            SizedBox(height: 12.h),
            Text(
              'Permissions:',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8.h),
            ...(plan.features ?? []).map(
              (perm) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check, size: 18.r, color: Colors.blue),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        perm.key ?? "NA",
                        style: getTextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
