import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/show_profile_visitor_controller.dart';

class ShowProfileVisitorList extends StatelessWidget {
  ShowProfileVisitorList({super.key});

  final controller = Get.find<ShowProfileVisitorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile visitor"),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Obx(() {
          if (controller.isUserLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.profileVisitor.isEmpty) {
            return Center(
              child: CustomText(
                text: "No user found!",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => controller.getProfileVisitorList(isRefresh: true),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                final userData = controller.profileVisitor[index];
                final userInfo = userData.profileViewer;
                return GestureDetector(
                  onTap: () {
                    log("go to chat screen");
                    Get.to(
                      () => IndividualChatScreen(),
                      arguments: {
                        "isActive": userInfo?.isOnline.toString() ?? "1",
                        "lastActiveData":
                            userInfo?.lastActivateAt ?? DateTime.now(),
                        "chatroomId": "",
                        "isLiked":
                            userInfo?.likeReceive != null &&
                                (userInfo?.likeReceive ?? []).isNotEmpty
                            ? true
                            : false,
                        "name": userInfo?.fullName ?? "NA",
                        "username": userInfo?.fullName ?? "NA",
                        "userId": userInfo?.id ?? "",
                        "image":
                            userInfo?.profileImage ??
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
                          backgroundImage:
                              (userInfo?.profileImage ?? "").isNotEmpty
                              ? NetworkImage(userInfo?.profileImage ?? "")
                              : AssetImage(ImagePath.appLogo),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: userInfo?.fullName ?? "NA",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            if (userInfo?.isOnline == 0) ...[
                              CustomText(
                                text:
                                    "last online ${timeAgo(userInfo?.lastActivateAt ?? DateTime.now())}",
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
                        CustomText(
                          text: timeAgo(userInfo?.updatedAt ?? DateTime.now()),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey4,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemCount: controller.profileVisitor.length,
            ),
          );
        }),
      ),
    );
  }
}
