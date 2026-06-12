// import 'package:flutter/material.dart';
// import 'package:quick_job/core/custom/global_text_style.dart';

// class CustomCategoryTile extends StatelessWidget {
//   final String title;
//   final String iconPath;
//   const CustomCategoryTile({
//     super.key,
//     required this.title,
//     required this.iconPath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           Image.asset(iconPath, width: 20, height: 20),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class CustomCategoryTile extends StatelessWidget {
  final String title;
  final String iconPath;

  const CustomCategoryTile({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 20.w, height: 20.h, fit: BoxFit.contain),
          SizedBox(width: 8.w),
          Text(
            title,
            style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
