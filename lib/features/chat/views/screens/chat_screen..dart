import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';

import '../../../../core/common/widgets/circular_profile_picture.dart';
import '../../../../core/common/widgets/custom_text.dart';
import '../../../../core/common/widgets/page_loader.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../controllers/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(text: "Messages", fontSize: 16.sp),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                if (controller.isUserLoading.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.height / 3,
                    ),
                    child: const PageLoader(),
                  );
                }
                // final conversationModel =
                //     controller.conversationListData.value;
                // final conversations = conversationModel?.result;
                // debugPrint('Conversation Model: $conversationModel');
                // debugPrint('Conversations List: $conversations');
                // debugPrint(
                //   'Conversations Length: ${conversations?.length}',
                // );
                if (controller.conversationListData.isEmpty) {
                  return SizedBox(
                    height: SizeUtils.height * 0.6,
                    child: Center(
                      child: CustomText(
                        text: "No chats yet",
                        color: AppColors.textSecondary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        await controller.getConversationList(isRefresh: true),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        final participant =
                            controller.conversationListData[index];
                        final data = participant.participants;

                        final lastMessageSendByMe =
                            participant.lastMessageUserId ==
                            AuthService.id.toString();
                        final messageStatus = participant.messageStatus;
                        final RxInt unseenCount = (participant.unseen ?? 0).obs;

                        return GestureDetector(
                          onTap: () {
                            log("Unseen count after : ${unseenCount.value}");
                            unseenCount.value = 0;
                            log("Unseen count before : ${unseenCount.value}");
                            Get.to(
                              () => IndividualChatScreen(),
                              arguments: {
                                "isActive": data?.isOnline ?? "1",
                                "lastActiveData":
                                    data?.lastActivateAt ?? DateTime.now(),
                                "chatroomId": participant.conversationId,
                                "isLiked": data?.isLike ?? false,
                                "name": data?.username ?? "NA",
                                "username": data?.username ?? "NA",
                                "userId": data?.userId ?? "",
                                "image":
                                    data?.image ??
                                    "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                              },
                            );
                            log("I am all data ${data?.userId ?? ""}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.h),
                              border: Border.all(
                                color: AppColors.textFormFieldBorder.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 15.h,
                            ),
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CircleAvatar(
                                //   radius: 22,
                                //   backgroundImage: NetworkImage(
                                //     participant?.image ?? "",
                                //   ),
                                // ),
                                CircularProfilePicture(
                                  imageLink:
                                      data?.image ??
                                      "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                  radius: 22.h,
                                  isActive: data?.isOnline ?? "1",
                                  lastActiveData:
                                      data?.lastActivateAt ?? DateTime.now(),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () => Expanded(
                                              child: CustomText(
                                                text: data?.username ?? "NA",
                                                maxLines: 1,
                                                fontWeight:
                                                    unseenCount.value > 0
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          if (participant.lastMessageTime !=
                                              null)
                                            Obx(
                                              () => CustomText(
                                                text: timeAgo(
                                                  participant.lastMessageTime ??
                                                      DateTime.now(),
                                                ),
                                                // text: DateFormat("hh:mm a")
                                                //     .format(
                                                //       participant.lastMessageTime!
                                                //           .toLocal(),
                                                //     ),
                                                fontSize: 11.sp,
                                                color: AppColors.textSecondary,
                                                fontWeight:
                                                    unseenCount.value > 0
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                            () => Expanded(
                                              child: CustomText(
                                                text: unseenCount.value > 0
                                                    ? "${unseenCount.value} unread message"
                                                    : lastMessageSendByMe
                                                    ? "You : ${participant.lastMessage ?? ''}"
                                                    : participant.lastMessage ??
                                                          '',
                                                color: AppColors.textSecondary,
                                                fontSize: 11.sp,
                                                maxLines: 2,
                                                fontWeight:
                                                    unseenCount.value > 0
                                                    ? FontWeight.w800
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          if (lastMessageSendByMe) ...[
                                            if (messageStatus == "send") ...[
                                              Icon(
                                                Icons.done,
                                                size: 16.sp,
                                                color: AppColors.textPrimary,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ] else if (messageStatus ==
                                                "seen") ...[
                                              Container(
                                                padding: EdgeInsets.all(
                                                  getHeight(4),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.textPrimary,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.done_all,
                                                  size: 16.sp,
                                                  color: AppColors.textWhite,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ] else ...[
                                              Icon(
                                                Icons.done_all,
                                                size: 16.sp,
                                                color: AppColors.textPrimary,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) =>
                          SizedBox(height: getHeight(0)),
                      itemCount: controller.conversationListData.length,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
