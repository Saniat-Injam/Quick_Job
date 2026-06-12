// import 'package:flutter/material.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';

// class OverviewCardWidget extends StatelessWidget {
//   final String label;
//   final String value;
//   final String? percentage;
//   final bool? isIncrease;

//   const OverviewCardWidget({
//     super.key,
//     required this.label,
//     required this.value,
//     this.percentage,
//     this.isIncrease,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(color: const Color(0xFFF3F4F6)),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0x0C000000),
//             blurRadius: 10.r,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: getTextStyle(
//               color: const Color(0xFF424242),
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             value,
//             style: getTextStyle(
//               color: const Color(0xFF212121),
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             children: [
//               Text(
//                 'This week: $percentage',
//                 style: getTextStyle(
//                   color: isIncrease!
//                       ? const Color(0xFF25AD3D)
//                       : const Color(0xFFD32F2F),
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(width: 4.w),
//               Icon(
//                 isIncrease! ? Icons.arrow_upward : Icons.arrow_downward,
//                 size: 10.r,
//                 color: isIncrease!
//                     ? const Color(0xFF25AD3D)
//                     : const Color(0xFFD32F2F),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class OverviewCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final int? percentage;
  final String? trend; // "UP" or "DOWN"

  const OverviewCardWidget({
    super.key,
    required this.label,
    required this.value,
    this.percentage,
    this.trend,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncrease = trend == 'UP';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getTextStyle(
              color: const Color(0xFF424242),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: getTextStyle(
              color: const Color(0xFF212121),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          if (percentage != null && trend != null)
            Row(
              children: [
                Text(
                  'This week',
                  style: getTextStyle(
                    color: const Color(0xFF757575),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.w),

                Text(
                  '$percentage%',
                  style: getTextStyle(
                    color: isIncrease
                        ? const Color(0xFF25AD3D)
                        : const Color(0xFFD32F2F),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 18.r,
                  color: isIncrease
                      ? const Color(0xFF25AD3D)
                      : const Color(0xFFD32F2F),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
