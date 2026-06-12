import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/notification/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel data;

  const NotificationTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final bool hasImage = data.imageUrl != null && data.imageUrl!.isNotEmpty;

    return Container(
      // margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 66.w,
            height: 66.h,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Icon(Icons.notifications, size: 34.sp),
          ),

          SizedBox(width: 4.w),

          // Text and Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title ?? "NA",
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  data.body ?? "NA",
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
