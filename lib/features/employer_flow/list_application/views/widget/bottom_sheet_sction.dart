// File: bottom_sheet_action.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';

class BottomSheetAction {
  static void show({
    required VoidCallback onEdit,
    required VoidCallback onDetail,
    VoidCallback? onDelete,
    VoidCallback? onPause,
  }) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: AppColors.textGrey,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: CustomText(
                text: "Action",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackPrimary,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            if (onDelete != null) ...[
              _actionItem(
                icon: CupertinoIcons.delete,
                label: "Delete",
                color: Colors.red,
                onTap: onDelete,
              ),
              SizedBox(height: 8.h),
              Divider(color: AppColors.textFormFieldBorder),
              SizedBox(height: 8.h),
            ],
            // if (onPause != null) ...[
            //   _actionItem(
            //     icon: Icons.pause,
            //     label: "Pause",
            //     color: AppColors.textSecondary,
            //     onTap: onPause,
            //   ),
            //   SizedBox(height: 8.h),
            //   Divider(color: AppColors.textFormFieldBorder),
            //   SizedBox(height: 8.h),
            // ],
            _actionItem(
              icon: Icons.edit,
              label: "Edit",
              color: AppColors.textSecondary,
              onTap: onEdit,
            ),
            SizedBox(height: 8.h),
            Divider(color: AppColors.textFormFieldBorder),
            SizedBox(height: 8.h),
            _actionItem(
              icon: Icons.info,
              label: "Detail",
              color: AppColors.textSecondary,
              onTap: onDetail,
            ),
            SizedBox(height: 26.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  static Widget _actionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(width: 8.w),
          CustomText(
            text: label,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: color == Colors.red ? Colors.red : Colors.black,
          ),
        ],
      ),
    );
  }
}
