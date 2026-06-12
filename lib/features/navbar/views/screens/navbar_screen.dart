// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/features/navbar/controllers/navbar_controller.dart';
// import '../widgets/custom_navbar_widget.dart';

// class NavBarScreen extends StatelessWidget {
//   NavBarScreen({super.key});

//   final NavBarController controller = Get.put(NavBarController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         body: controller.currentPage, // Reactive page
//         bottomNavigationBar: const CustomBottomNavigationBar(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/features/navbar/controllers/navbar_controller.dart';
// import '../widgets/custom_navbar_widget.dart';

// class NavBarScreen extends StatelessWidget {
//   final String role; // 👈 Accept role from previous screen/login

//   NavBarScreen({super.key, required this.role});

//   @override
//   Widget build(BuildContext context) {
//     // 👇 Initialize controller with role
//     final NavBarController controller = Get.put(NavBarController(role: role));

//     return Obx(
//       () => Scaffold(
//         body: controller.currentPage,
//         bottomNavigationBar: const CustomBottomNavigationBar(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/features/navbar/controllers/navbar_controller.dart';
import '../widgets/custom_navbar_widget.dart';

class NavBarScreen extends StatelessWidget {

  NavBarScreen({super.key});

  final NavBarController controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() =>
        controller.navItems[controller.selectedIndex.value].page
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

