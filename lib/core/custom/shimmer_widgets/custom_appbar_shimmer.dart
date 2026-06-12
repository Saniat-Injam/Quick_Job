import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class CustomAppBarShimmer extends StatelessWidget
    implements PreferredSizeWidget {
  final double? height;

  const CustomAppBarShimmer({super.key, this.height});

  @override
  Size get preferredSize => Size.fromHeight(height?.h ?? 60.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h ?? 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Leading circle placeholder
            Container(
              width: 45.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.w),

            // 🔹 Title placeholder (flexible width)
            Expanded(
              child: Container(
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // 🔹 Trailing icon placeholder
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
