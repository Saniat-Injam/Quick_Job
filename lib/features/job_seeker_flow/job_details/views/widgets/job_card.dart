import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String imageUrl;

  const JobCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = imageUrl.isNotEmpty && imageUrl.startsWith('http');

    Widget companyLogoWidget;

    if (isNetworkImage) {
      companyLogoWidget = Image.network(
        imageUrl,
        width: 50.w,
        height: 50.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.business_center, size: 40.w, color: AppColors.textGrey);
        },
      );
    } else if (imageUrl.isNotEmpty) {
      companyLogoWidget = Image.asset(
        imageUrl,
        width: 50.w,
        height: 50.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.business_center, size: 40.w, color: AppColors.textGrey);
        },
      );
    } else {
      companyLogoWidget = Icon(Icons.business_center, size: 40.w, color: AppColors.textGrey);
    }

    final sizedLogo = SizedBox(
      width: 50.w,
      height: 50.h,
      child: companyLogoWidget,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x288E8DD0),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          sizedLogo,
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  companyName,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black4,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}