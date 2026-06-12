import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class OverviewCardSkeleton extends StatelessWidget {
  const OverviewCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFF3F4F6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 12.h, width: 80.w, color: Colors.grey),
            SizedBox(height: 6.h),
            Container(height: 20.h, width: 40.w, color: Colors.grey),
            SizedBox(height: 8.h),
            Row(
              children: [
                Container(height: 12.h, width: 20.w, color: Colors.grey),
                SizedBox(width: 4.w),
                Container(height: 12.h, width: 30.w, color: Colors.grey),
                Spacer(),
                Container(height: 10.h, width: 40.w, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:shimmer/shimmer.dart';
// import 'package:flutter/material.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';

// class OverviewCardSkeleton extends StatelessWidget {
//   const OverviewCardSkeleton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       period: const Duration(milliseconds: 1200), // smooth shimmer speed
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: const Color(0xFFF3F4F6)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8.r,
//               offset: Offset(0, 4.h),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Label skeleton
//             Container(
//               height: 12.h,
//               width: 60.w,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade400,
//                 borderRadius: BorderRadius.circular(6.r),
//               ),
//             ),
//             SizedBox(height: 8.h),

//             // Value skeleton
//             Container(
//               height: 20.h,
//               width: 40.w,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade400,
//                 borderRadius: BorderRadius.circular(6.r),
//               ),
//             ),
//             SizedBox(height: 12.h),

//             // Percentage + trend skeleton
//             Row(
//               children: [
//                 Container(
//                   height: 12.h,
//                   width: 20.w,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(6.r),
//                   ),
//                 ),
//                 SizedBox(width: 6.w),
//                 Container(
//                   height: 12.h,
//                   width: 30.w,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(6.r),
//                   ),
//                 ),
//                 const Spacer(),
//                 Container(
//                   height: 10.h,
//                   width: 35.w,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(6.r),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
