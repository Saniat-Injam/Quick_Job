import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/image_path.dart';

class CircularProfilePicture extends StatelessWidget {
  const CircularProfilePicture({
    super.key,
    required this.imageLink,
    this.radius,
    this.backgroundColor,
    this.padding,
    required this.isActive,
    required this.lastActiveData,
    this.showDataStatus,
  });

  final String? imageLink;
  final double? radius;
  final double? padding;
  final Color? backgroundColor;
  final String isActive;
  final DateTime lastActiveData;
  final bool? showDataStatus;

  @override
  Widget build(BuildContext context) {
    bool isOnline = isActive == "1";
    DateTime lastActive = lastActiveData;
    bool showGrey = !isOnline && isMoreThanOneHour(lastActive);

    return CircleAvatar(
      radius: radius ?? 24.h,
      backgroundColor: backgroundColor ?? AppColors.primary,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding ?? 2.w,
              vertical: padding ?? 2.w,
            ),
            child: ClipOval(
              child: imageLink == null || imageLink == ""
                  ? Image.asset(
                      ImagePath.albertFlores,
                      fit: BoxFit.fitHeight,
                      height: double.infinity,
                      width: double.infinity,
                    )
                  : Image.network(
                      imageLink ??
                          "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                    ),
            ),
          ),

          if (showDataStatus ?? true) ...[
            if (!isOnline && !showGrey) ...[
              Positioned(
                right: getWidth(0),
                bottom: getHeight(0),
                child: Container(
                  padding: EdgeInsets.all(getHeight(6)),
                  decoration: BoxDecoration(
                    color: AppColors.textYellow,
                    shape: BoxShape.circle,
                  ),
                  child: CustomText(
                    text: getLastActiveText(lastActive),
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ] else ...[
              Positioned(
                right: getWidth(0),
                bottom: getHeight(0),
                child: Container(
                  height: getHeight(12),
                  width: getWidth(12),
                  decoration: BoxDecoration(
                    color: isOnline
                        ? AppColors.greenPrimary
                        : showGrey
                        ? AppColors.textGrey
                        : AppColors.greenPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
