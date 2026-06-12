import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/views/employer_edit_profile_screen_for_client.dart';
import 'package:quick_job/features/profile_flow/help/views/screens/help_screen.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/views/screens/job_seeker_edit_profile_screen.dart';
import 'package:quick_job/features/profile_flow/go_premium/controllers/premium_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/profile_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/views/screens/favorite_list_screen.dart';
import 'package:quick_job/features/profile_flow/profile_home/views/screens/show_profile_visitor_list.dart';
import 'package:quick_job/features/profile_flow/profile_home/views/screens/upload_gallery_photos.dart';
import 'package:quick_job/features/profile_flow/profile_home/views/widgets/logout_dialog.dart';
import 'package:quick_job/features/profile_flow/profile_home/views/widgets/profile_menu_card.dart';

class ProfileScreen extends GetView<ProfileController> {
  // final ProfileController profileController = Get.find();
  final PremiumController premiumController = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.greyPrimary,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              controller.profileImage.value.startsWith('http')
                              ? NetworkImage(controller.profileImage.value)
                              : NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Profile',
                      style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Profile Image Container
                        Obx(() {
                          if (controller.isImageUploading.value) {
                            SizedBox(
                              width: 80.w,
                              height: 80.w,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: AppColors.greyPrimary,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:
                                    controller.profileImage.value.startsWith(
                                      'http',
                                    )
                                    ? NetworkImage(
                                        controller.profileImage.value,
                                      )
                                    : NetworkImage(
                                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                                      ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: SvgPicture.asset(
                              IconPath.imagePicker,
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userName.value,
                            style: getTextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF424242),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            controller.email.value,
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF616161),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          // Text(
                          //   profileController.displayRole,
                          //   style: getTextStyle(
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w500,
                          //     color: const Color(0xFF616161),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        log("click eye");
                        Get.to(() => ShowProfileVisitorList());
                      },
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.primary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1EBDC5D3),
                      blurRadius: 16.r,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileMenuCard(
                      iconPath: IconPath.editProfile,
                      title: 'Edit Profile',
                      onTap: () {
                        log(AuthService.role.toString());
                        if (AuthService.role == 'JOB_SEEKERS') {
                          Get.to(() => JobSeekerEditProfileScreen());
                        } else {
                          // Get.to(() => EmployerEditProfileScreen());
                          Get.to(() => EmployerEditProfileScreenForClient());
                        }
                      },
                    ),
                    // Divider(),
                    // // this is for notification
                    // Obx(
                    //   () => ProfileMenuCard(
                    //     iconPath: IconPath.favourites,
                    //     title: "Notifications",
                    //     isNotification: true,
                    //     notificationValue: controller.isNotifyOn.value,
                    //     onToggle: (val) {
                    //       controller.isNotifyOn.value = val;
                    //     },
                    //   ),
                    // ),
                    Divider(),
                    ProfileMenuCard(
                      iconPath: IconPath.goPremium,
                      title: 'Go Premium',
                      onTap: premiumController.showPremiumBottomSheet,
                    ),
                    Divider(),
                    ProfileMenuCard(
                      iconPath: IconPath.upload,
                      title: 'Gallery images',
                      onTap: () {
                        log("Go to gallery images screen");
                        Get.to(() => UploadGalleryPhoto());
                      },
                    ),
                    Divider(),
                    ProfileMenuCard(
                      iconPath: IconPath.favourites,
                      title: 'Favorite list',
                      onTap: () {
                        log("Go to favorite screen");
                        Get.to(() => FavoriteListScreen());
                      },
                    ),
                    Divider(),
                    ProfileMenuCard(
                      iconPath: IconPath.privacyPolicy,
                      title: 'Help',
                      onTap: () {
                        Get.to(() => HelpScreen());
                      },
                    ),
                    Divider(),
                    ProfileMenuCard(
                      iconPath: IconPath.logout,
                      title: 'Logout',
                      titleColor: const Color(0xFFD32F2F),
                      onTap: () {
                        showLogoutDialog();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
