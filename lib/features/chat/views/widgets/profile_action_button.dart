// import 'package:flutter/material.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';

// class ProfileActionButton extends StatelessWidget {
//   final Color color;
//   final String icon;
//   final VoidCallback onTap;

//   const ProfileActionButton({
//     super.key,
//     required this.color,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(30.r),
//       child: Container(
//         width: 60.w,
//         height: 60.w,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(30.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 12.r,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 28.sp),
//       ),
//     );
//   }
// }
