// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/custom/custom_button.dart';
// import 'package:quick_job/core/custom/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/core/utils/constants/image_path.dart';
// import 'package:quick_job/features/role/controllers/role_selection_controller.dart';
// import 'package:quick_job/features/role/views/widgets/role_card.dart';

// class RoleSelectionScreen extends StatelessWidget {
//   final RoleSelectionController roleSelectionController = Get.put(
//     RoleSelectionController(),
//   );
//   RoleSelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 62.h),
//                 Center(
//                   child: Image.asset(
//                     ImagePath.quickJob,
//                     height: 196.h,
//                     width: 160.w,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(height: 72.h),
//                 Text(
//                   'Continue as',
//                   style: getTextStyle(
//                     fontSize: 30.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.blackPrimary,
//                     height: 1.3.h,
//                   ),
//                 ),
//                 SizedBox(height: 10.h),
//                 Text(
//                   'There are various categories that assist you in finding a job based on your interest.',
//                   style: getTextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     height: 1.4.h,
//                     color: AppColors.black4,
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 Obx(
//                   () => Column(
//                     children: roleSelectionController.roles
//                         .map(
//                           (role) => RoleCard(
//                             role: role,
//                             isSelected:
//                                 roleSelectionController.selectedRole.value ==
//                                 role,
//                             onTap: () =>
//                                 roleSelectionController.onRoleSelected(role),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
//           child: Obx(
//             () => CustomButton(
//               onPressed: roleSelectionController.goToNextPage,
//               text: "Continue",
//               // onPressed: roleSelectionController.selectedRole.value == null
//               //     ? null // disable if not selected
//               //     : roleSelectionController.goToNextPage,
//               borderRadius: 99,
//               buttonColor: roleSelectionController.selectedRole.value == null
//                   ? AppColors.blueSecondary
//                   : AppColors.bluePrimary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/role/controllers/role_selection_controller.dart';
import 'package:quick_job/features/role/views/widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  RoleSelectionScreen({super.key});

  final RoleSelectionController controller = Get.put(RoleSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 62.h),
                Center(
                  child: Image.asset(
                    ImagePath.quickJob,
                    height: 196.h,
                    width: 160.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 72.h),
                Text(
                  'Continue as',
                  style: getTextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackPrimary,
                    height: 1.3.h,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'There are various categories that assist you in finding a job based on your interest.',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4.h,
                    color: AppColors.black4,
                  ),
                ),
                SizedBox(height: 24.h),

                /// Role selection cards
                Obx(
                  () => Column(
                    children: controller.roles.map((role) {
                      final isSelected = controller.selectedRole.value == role;
                      return RoleCard(
                        role: role,
                        isSelected: isSelected,
                        onTap: () => controller.onRoleSelected(role),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      /// Continue button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
          child: Obx(
            () => CustomButton(
              
            
              onPressed: controller.goToNextPage,
              text: "Continue",
              borderRadius: 99,
              buttonColor: controller.selectedRole.value == null
                  ? AppColors.blueSecondary
                  : AppColors.bluePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
