// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/core/utils/constants/icon_path.dart';
// import 'package:quick_job/features/job_seeker_flow/job_details/controllers/resume_controller.dart';

// class ResumeUploadCard extends StatelessWidget {
//   const ResumeUploadCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<ResumeController>();

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFA2C6FF)),
//         borderRadius: BorderRadius.circular(14),
//         color: const Color(0xFFF9FAFB),
//       ),
//       child: Column(
//         children: [
//           SvgPicture.asset(IconPath.uploadResume, height: 40.h, width: 40.w),
//           SizedBox(height: 10.h),
//           Text(
//             'Upload Resume',
//             style: getTextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//               color: AppColors.black3,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'Supports: PDF, DOC, DOCX • Max 10MB',
//             style: getTextStyle(
//               color: AppColors.black4,
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SizedBox(height: 14.h),
//           Row(
//             children: [
//               // Expanded(
//               //   child: CustomButton(
//               //     onPressed: controller.takePhoto,
//               //     text: 'Take Photo',
//               //     style: getTextStyle(
//               //       fontSize: 12.sp,
//               //       fontWeight: FontWeight.w400,
//               //       color: AppColors.black3,
//               //     ),
//               //     buttonColor: AppColors.backgroundColor,
//               //     borderColor: AppColors.borderPrimary,
//               //     borderRadius: 8000.r,
//               //     height: 40.h,
//               //   ),
//               // ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: CustomButton(
//                   onPressed: controller.pickFile,
//                   text: 'Coose File',
//                   style: getTextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.black3,
//                   ),
//                   buttonColor: AppColors.backgroundColor,
//                   borderColor: AppColors.borderPrimary,
//                   borderRadius: 8000.r,
//                   height: 40.h,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Obx(() {
//             final file = controller.selectedFile.value;
//             if (file == null) return const SizedBox.shrink();
//             return Text(
//               'Selected: ${file.name}',
//               style: getTextStyle(
//                 fontSize: 12,
//                 color: Colors.green,
//                 fontWeight: FontWeight.w500,
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/controller/job_seeker_update_profile_controller.dart';

class ResumeUploadCard extends StatelessWidget {
  const ResumeUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobSeekerUpdateProfileController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFA2C6FF)),
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFF9FAFB),
      ),
      child: Column(
        children: [
          SvgPicture.asset(IconPath.uploadResume, height: 40.h, width: 40.w),
          SizedBox(height: 10.h),
          Text(
            'Upload Resume',
            style: getTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black3,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Supports: Only PDF file • Max 10MB',
            style: getTextStyle(
              color: AppColors.black4,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  onPressed: controller.pickFile,
                  text: 'Choose File',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black3,
                  ),
                  buttonColor: AppColors.backgroundColor,
                  borderColor: AppColors.borderPrimary,
                  borderRadius: 8000.r,
                  height: 40.h,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            final file = controller.selectedFile.value;
            if (file == null) return const SizedBox.shrink();
            return Text(
              'Selected: ${file.path.split('/').last} (${(file.lengthSync() / 1024).toStringAsFixed(2)} KB)',
              style: getTextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
        ],
      ),
    );
  }
}
