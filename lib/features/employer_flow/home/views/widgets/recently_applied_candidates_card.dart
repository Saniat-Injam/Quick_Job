import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';

class RecentlyAppliedCandidatesCard extends StatelessWidget {
  final String name;
  final String title;
  final String image;
  final VoidCallback? onSeeResume;
  final VoidCallback? onSeeDetails;
  final VoidCallback? onChatTap;
  final VoidCallback? onCallTap;

  const RecentlyAppliedCandidatesCard({
    super.key,
    required this.name,
    required this.title,
    required this.image,
    required this.onCallTap,
    required this.onChatTap,
    this.onSeeResume,
    this.onSeeDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Avatar + Name + Title
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage: image.startsWith('http')
                    ? NetworkImage(image)
                    : AssetImage(ImagePath.albertFlores),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      title,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF616161),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: onChatTap,
                icon: Icon(
                  Icons.chat,
                  size: 22.sp,
                  color: AppColors.bluePrimary,
                ),
              ),
              IconButton(
                onPressed: onCallTap,
                icon: Icon(
                  Icons.call,
                  size: 22.sp,
                  color: AppColors.bluePrimary,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Divider(color: const Color(0xFFD1D6DB)),

          SizedBox(height: 9.h),

          // Buttons See Resume & See Details
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onSeeResume,
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E55FD),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'See Resume',
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: GestureDetector(
                  onTap: onSeeDetails,
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF0E55FD)),
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'See Details',
                      style: getTextStyle(
                        color: const Color(0xFF0E55FD),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
