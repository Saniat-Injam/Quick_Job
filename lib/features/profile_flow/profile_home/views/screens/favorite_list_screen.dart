import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/favorite_list_controller.dart';

class FavoriteListScreen extends StatelessWidget {
  FavoriteListScreen({super.key});

  final controller = Get.find<FavoriteListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Favorite list"),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Obx(() {
          if (controller.isUserLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (controller.likedUserData.isEmpty) {
            return Center(
              child: CustomText(
                text: "User not found",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => controller.getFavoriteUserList(isRefresh: true),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                final userData = controller.likedUserData[index];
                final info = userData.likeReceive;
                return GestureDetector(
                  onTap: () {
                    log("go to chat screen");
                    Get.to(
                      () => IndividualChatScreen(),
                      arguments: {
                        "isActive": info?.isOnline.toString() ?? "1",
                        "lastActiveData":
                            info?.lastActivateAt ?? DateTime.now(),
                        "chatroomId": "",
                        "isLiked": true,
                        "name": info?.fullName ?? "NA",
                        "username": info?.fullName ?? "NA",
                        "userId": info?.id ?? "",
                        "image":
                            info?.profileImage ??
                            "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFormFieldBorder),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: (info?.profileImage ?? "").isNotEmpty
                              ? NetworkImage(info?.profileImage ?? "")
                              : AssetImage(ImagePath.appLogo),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: info?.fullName ?? "NA",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            if (info?.isOnline == 0) ...[
                              CustomText(
                                text:
                                    "last online ${timeAgo(info?.lastActivateAt ?? DateTime.now())}",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ] else ...[
                              CustomText(
                                text: "Online",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greenPrimary,
                              ),
                            ],
                          ],
                        ),
                        Spacer(),
                        Icon(
                          CupertinoIcons.chat_bubble,
                          size: 24.sp,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemCount: controller.likedUserData.length,
            ),
          );
        }),
      ),
    );
  }
}
