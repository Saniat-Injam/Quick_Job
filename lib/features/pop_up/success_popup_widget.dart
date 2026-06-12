// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/features/pop_up/pop_up_controller.dart';

// class SuccessPopupWidget extends StatelessWidget {
//   const SuccessPopupWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SuccessPopupController());

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 🎯 Main success icon circle
//             Container(
//               width: 120,
//               height: 120,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFF0E55FD),
//               ),
//               child: const Icon(
//                 Icons.check_rounded,
//                 color: Colors.white,
//                 size: 64,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // ✅ Title and Message
//             Obx(
//               () => Column(
//                 children: [
//                   Text(
//                     controller.title.value,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Color(0xFF10110E),
//                       fontSize: 20,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w600,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     controller.message.value,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Color(0xFF757575),
//                       fontSize: 14,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // 🔘 Close Button
//             ElevatedButton(
//               onPressed: controller.closePopup,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF0E55FD),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 minimumSize: const Size(150, 48),
//               ),
//               child: const Text(
//                 'Continue',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/pop_up/pop_up_controller.dart';

class SuccessPopupWidget extends StatelessWidget {
  const SuccessPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuccessPopupController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Main success circle icon
            // Container(
            //   width: 120,
            //   height: 120,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xFF0E55FD),
            //   ),
            //   child: Image.asset(ImagePath.popupImage),
            // ),
            Image.asset(ImagePath.popupImage, width: 175.42, height: 157.99),
            const SizedBox(height: 24),

            // ✅ Title & message
            Obx(
              () => Column(
                children: [
                  Text(
                    controller.title.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF10110E),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    controller.message.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const SpinKitCircle(color: Color(0xFF0057FF), size: 50),

            // ✅ Continue button
            // ElevatedButton(
            //   onPressed: controller.closePopup,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xFF0E55FD),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //     minimumSize: const Size(150, 48),
            //   ),
            //   child: const Text(
            //     'Continue',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
