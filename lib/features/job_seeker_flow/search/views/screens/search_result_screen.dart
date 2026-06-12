// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/features/job_seeker_flow/search/controllers/search_result_job_controller.dart';
// import 'package:quick_job/features/job_seeker_flow/search/views/widgets/search_result_job_card.dart';

// class SearchScreen2 extends StatelessWidget {
//   SearchScreen2({super.key});

//   final SearchResultJobController searchResultJobController = Get.put(
//     SearchResultJobController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFB),
//       appBar: AppBar(
//         title: const Text('Search Jobs'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(
//               () => Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Results',
//                     style: getTextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.black6,
//                     ),
//                   ),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text:
//                               // '${searchResultJobController.totalResults.value} ',
//                               // ignore: invalid_use_of_protected_member
//                               '${searchResultJobController.filteredJobs.value} ',
//                           style: getTextStyle(
//                             color: AppColors.blue3,
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'founds',
//                           style: getTextStyle(
//                             color: AppColors.black7,
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//             Expanded(
//               child: Obx(
//                 () => ListView.builder(
//                   itemCount: searchResultJobController.allJobs.length,
//                   itemBuilder: (context, index) {
//                     return SearchResultJobCard(
//                       job: searchResultJobController.allJobs[index],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
