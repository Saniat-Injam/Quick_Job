// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/core/utils/constants/icon_path.dart';

// class ProfileMenuCard extends StatelessWidget {
//   final String iconPath;
//   final String title;
//   final VoidCallback? onTap;
//   final Color? titleColor;

//   const ProfileMenuCard({
//     super.key,
//     required this.iconPath,
//     required this.title,
//     this.onTap,
//     this.titleColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 12.h),
//         child: Row(
//           children: [
//             SvgPicture.asset(iconPath),
//             SizedBox(width: 16.w),
//             Expanded(
//               child: Text(
//                 title,
//                 style: getTextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: titleColor ?? const Color(0xFF616161),
//                 ),
//               ),
//             ),
//             SvgPicture.asset(IconPath.rightAngle, width: 20.w, height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';

class ProfileMenuCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  final Color? titleColor;

  // NEW: to show/hide toggle button
  final bool isNotification;
  final bool notificationValue;
  final ValueChanged<bool>? onToggle;

  const ProfileMenuCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.titleColor,
    this.isNotification = false,
    this.notificationValue = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isNotification ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(width: 16.w),

            Expanded(
              child: Text(
                title,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: titleColor ?? const Color(0xFF616161),
                ),
              ),
            ),

            // if (isNotification)
            //   Switch(value: notificationValue, onChanged: onToggle)
            // else
            //   SvgPicture.asset(IconPath.rightAngle, width: 20.w, height: 20.h),

            // ✔ If notification → show toggle
            if (isNotification)
              SizedBox(
                height: 20.h, // same height as your rightAngle icon
                child: Transform.scale(
                  scale: 0.8, // adjust switch size (optional)
                  child: Switch(
                    value: notificationValue,
                    onChanged: onToggle,
                    activeThumbColor: AppColors.bluePrimary,
                  ),
                ),
              )
            else
              SvgPicture.asset(IconPath.rightAngle, width: 20.w, height: 20.h),
          ],
        ),
      ),
    );
  }
}
