// import 'package:flutter/material.dart';
// import 'package:quick_job/core/custom/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final Color buttonColor;
//   final Color? borderColor;
//   final double height;
//   final double borderRadius;
//   final TextStyle? style;

//   const CustomButton({
//     super.key,
//     required this.text,
//     this.onPressed,
//     this.buttonColor = AppColors.bluePrimary,
//     this.borderColor,
//     this.height = 60,
//     this.borderRadius = 8,
//     this.style,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: height.h,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(borderRadius.r),
//         onTap: onPressed,
//         child: Container(
//           decoration: BoxDecoration(
//             color: buttonColor,
//             borderRadius: BorderRadius.circular(borderRadius.r),
//             boxShadow: [
//               BoxShadow(
//                 color: buttonColor.withValues(alpha: 0.3),
//                 blurRadius: 10.r,
//                 offset: Offset(0, 4.h),
//               ),
//             ],
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             text,
//             style:
//                 style ??
//                 getTextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final Color? borderColor;
  final double height;
  final double borderRadius;
  final TextStyle? style;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonColor = AppColors.bluePrimary,
    this.borderColor,
    this.height = 48,
    this.borderRadius = 8,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height.h,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius.r),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius.r),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: buttonColor.withValues(alpha: 0.3),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style:
                style ??
                getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
