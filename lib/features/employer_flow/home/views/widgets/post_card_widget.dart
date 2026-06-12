// import 'package:flutter/material.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';

// class PostCardWidget extends StatelessWidget {
//   final String title;
//   final String company;
//   final String location;
//   final String status;
//   final String salary;
//   final String? image;

//   const PostCardWidget({
//     super.key,
//     required this.title,
//     required this.company,
//     required this.location,
//     required this.status,
//     required this.salary,
//     this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 84.h,
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: const Color(0xFFF3F4F6)),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0x0C000000),
//             blurRadius: 10.r,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 64.w,
//             height: 64.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.r),
//               image: DecorationImage(
//                 image: AssetImage(image!),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(width: 14.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   title,
//                   style: getTextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   company,
//                   style: getTextStyle(
//                     fontSize: 12.sp,
//                     color: const Color(0xFF616161),
//                   ),
//                 ),
//                 SizedBox(height: 4.h),

//                 Text(
//                   location,
//                   style: getTextStyle(
//                     fontSize: 12.sp,
//                     color: const Color(0xFF757575),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 12.w,
//                   vertical: 3.5.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0x2852C41A),
//                   borderRadius: BorderRadius.circular(30.r),
//                 ),
//                 child: Text(
//                   status,
//                   style: getTextStyle(
//                     color: const Color(0xFF25AD3D),
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12.h),
//               Text(
//                 salary,
//                 style: getTextStyle(
//                   color: const Color(0xFF0E55FD),
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';

class PostCardWidget extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String status;
  final String salary;
  final String image;

  const PostCardWidget({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.status,
    required this.salary,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: image.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, __, ___) =>
                          Image.asset(ImagePath.floydMiles, fit: BoxFit.cover),
                    )
                  : Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  company,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF616161),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  location,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 3.5.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x2852C41A),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  status,
                  style: getTextStyle(
                    color: const Color(0xFF25AD3D),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                salary,
                style: getTextStyle(
                  color: const Color(0xFF0E55FD),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
