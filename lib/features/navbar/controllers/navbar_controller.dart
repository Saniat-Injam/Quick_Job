// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/features/job_seeker_flow/chat/views/screens/chat_screen.dart';
// import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/sceens/home_screen.dart';
// import 'package:quick_job/features/job_seeker_flow/profile/views/screens/profile_screen.dart';
// import '../models/navbar_item_model.dart';
// import 'package:quick_job/features/job_seeker_flow/application/views/screens/job_application_screen.dart';

// class NavBarController extends GetxController {
//   // Reactive selected index
//   var selectedIndex = 0.obs;

//   // Reactive nav items list
//   var navItems = <NavbarItem>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize nav items
//     navItems.value = [
//       NavbarItem(
//         iconPath: 'assets/icons/home.svg',
//         label: 'Home',
//         page: const HomeScreen(),
//       ),
//       NavbarItem(
//         iconPath: 'assets/icons/chat.svg',
//         label: 'Chat',
//         page: ChatScreen(),
//       ),
//       NavbarItem(
//         iconPath: 'assets/icons/application.svg',
//         label: 'Application',
//         page: JobApplicationsScreen(),
//       ),
//       NavbarItem(
//         iconPath: 'assets/icons/account.svg',
//         label: 'Account',
//         // onTap: () {
//         //   Get.to(
//         //     () => const AccountScreen(),
//         //   ); // Example: navigate to external screen
//         // },
//         page: ProfileScreen(),
//       ),
//     ];
//   }

//   // Change selected index
//   void changeIndex(int index) {
//     final item = navItems[index];
//     if (item.onTap != null) {
//       item.onTap!(); // External navigation
//     } else {
//       selectedIndex.value = index; // Tab switch
//     }
//   }

//   // Get current page
//   Widget get currentPage => navItems[selectedIndex.value].page;
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/features/employer_flow/home/views/employer_home.dart';
// import 'package:quick_job/features/employer_flow/list_application/views/screens/employer_applications_screen.dart';
// import 'package:quick_job/features/job_seeker_flow/chat/views/screens/chat_screen.dart';
// import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/sceens/home_screen.dart';
// import 'package:quick_job/features/job_seeker_flow/profile/views/screens/profile_screen.dart';
// import '../models/navbar_item_model.dart';
// import 'package:quick_job/features/job_seeker_flow/application/views/screens/job_application_screen.dart';

// class NavBarController extends GetxController {
//   // Reactive selected index
//   var selectedIndex = 0.obs;

//   // Reactive nav items list
//   var navItems = <NavbarItem>[].obs;

//   // Role: either "job_seeker" or "employer"
//   final String role;

//   // Constructor to receive the role when initializing
//   NavBarController({required this.role});

//   @override
//   void onInit() {
//     super.onInit();

//     if (role == 'employer') {
//       // 👨‍💼 Employer navigation setup
//       navItems.value = [
//         NavbarItem(
//           iconPath: 'assets/icons/home.svg',
//           label: 'Home',
//           page: const EmployerHomeScreen(),
//         ),
//         NavbarItem(
//           iconPath: 'assets/icons/chat.svg',
//           label: 'Chat',
//           page: ChatScreen(),
//         ),
//         NavbarItem(
//           iconPath: 'assets/icons/application.svg',
//           label: 'Applications',
//           page: EmployerApplicationsScreen(),
//         ),
//         NavbarItem(
//           iconPath: 'assets/icons/account.svg',
//           label: 'Account',
//           page: ProfileScreen(),
//         ),
//       ];
//     } else {
//       // 👩‍💼 Job seeker navigation setup
//       navItems.value = [
//         NavbarItem(
//           iconPath: 'assets/icons/home.svg',
//           label: 'Home',
//           page: const HomeScreen(),
//         ),
//         NavbarItem(
//           iconPath: 'assets/icons/chat.svg',
//           label: 'Chat',
//           page: ChatScreen(),
//         ),
//         NavbarItem(
//           iconPath: 'assets/icons/application.svg',
//           label: 'Application',
//           page: JobApplicationsScreen(),
//         ),
//         NavbarItem(
//           iconPath: 'assets/icons/account.svg',
//           label: 'Account',
//           page: ProfileScreen(),
//         ),
//       ];
//     }
//   }

//   // Change selected index
//   void changeIndex(int index) {
//     final item = navItems[index];
//     if (item.onTap != null) {
//       item.onTap!(); // external navigation
//     } else {
//       selectedIndex.value = index; // tab switch
//     }
//   }

//   // Get current page
//   Widget get currentPage => navItems[selectedIndex.value].page;
// }

import 'dart:developer';

import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/features/employer_flow/home/views/screens/employer_home_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/employer_applications_screen.dart';
import 'package:quick_job/features/chat/views/screens/chat_screen..dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/sceens/job_seeker_home_screen.dart';
import 'package:quick_job/features/profile_flow/profile_home/views/screens/profile_screen.dart';
import 'package:quick_job/features/navbar/models/navbar_item_model.dart';
import 'package:quick_job/features/job_seeker_flow/application/views/screens/job_application_screen.dart';

class NavBarController extends GetxController {
  final String role = AuthService.role.toString();

  var selectedIndex = 0.obs;
  var navItems = <NavbarItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    log("I am here in navbar");
    if (role == 'JOB_SEEKERS') {
      navItems.value = [
        NavbarItem(
          iconPath: 'assets/icons/home.svg',
          label: 'Home',
          page: HomeScreen(userRole: 'JOB_SEEKERS'),
        ),
        NavbarItem(
          iconPath: 'assets/icons/chat.svg',
          label: 'My Chat',
          page: ChatScreen(),
        ),
        NavbarItem(
          iconPath: 'assets/icons/application.svg',
          label: 'My Application',
          page: JobApplicationsScreen(),
        ),
        NavbarItem(
          iconPath: 'assets/icons/account.svg',
          label: 'Account',
          page: ProfileScreen(),
        ),
      ];
    } else {
      navItems.value = [
        NavbarItem(
          iconPath: 'assets/icons/home.svg',
          label: 'Home',
          page: EmployerHomeScreen(userRole: 'EMPLOYER'),
        ),
        NavbarItem(
          iconPath: 'assets/icons/chat.svg',
          label: 'My Chat',
          page: ChatScreen(),
        ),
        NavbarItem(
          iconPath: 'assets/icons/application.svg',
          label: 'My Application',
          page: EmployerApplicationsScreen(),
        ),
        NavbarItem(
          iconPath: 'assets/icons/account.svg',
          label: 'Account',
          page: ProfileScreen(),
        ),
      ];
    }
  }

  void changeIndex(int index) {
    final item = navItems[index];
    if (item.onTap != null) {
      item.onTap!();
    } else {
      selectedIndex.value = index;
    }
  }

  //Widget get currentPage => navItems[selectedIndex.value].page;
}
