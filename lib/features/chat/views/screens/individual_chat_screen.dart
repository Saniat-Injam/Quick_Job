import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/controllers/individual_chat_controller.dart';
import 'package:quick_job/features/chat/views/screens/view_user_details_screen.dart';
import 'package:quick_job/features/chat/views/widgets/individual_chat_widgets/chat_bubble.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../core/common/widgets/circular_profile_picture.dart';

class IndividualChatScreen extends StatelessWidget {
  IndividualChatScreen({super.key});

  final controller = Get.find<IndividualChatController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final image = arguments['image'] ?? '';
    final name = arguments['name'] ?? '';
    final isActive = arguments['isActive'] ?? "";
    final lastActiveData = arguments['lastActiveData'] ?? DateTime.now();

    bool isOnline = isActive == "1";
    DateTime lastActive = lastActiveData;
    bool showGrey = !isOnline && isMoreThanOneHour(lastActive);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        didPop = true;
        return controller.socketController.leavePrivateChat();
      },
      child: Scaffold(
        // backgroundColor: const Color(0xFFF9FAFB),
        backgroundColor: AppColors.textWhite,
        body: Stack(
          children: [
            /// ================= HEADER =================
            Positioned(
              top: getHeight(40),
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: getHeight(16),
                  left: getWidth(16),
                  right: getWidth(16),
                  bottom: 0,
                ),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: 8.w),
                    CircularProfilePicture(
                      showDataStatus: false,
                      imageLink: image,
                      radius: 18.h,
                      isActive: isActive,
                      lastActiveData: DateTime.now(),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => ViewUserDetailsScreen(),
                          arguments: {'userId': controller.userId},
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: getTextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // SizedBox(height: 4.h),
                            if (!isOnline && !showGrey) ...[
                              Container(
                                padding: EdgeInsets.all(getHeight(4)),
                                decoration: BoxDecoration(
                                  color: AppColors.textWhite,
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomText(
                                  text:
                                      "last online ${getLastActiveText(lastActive)} ago",
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ] else ...[
                              CustomText(
                                text: showGrey ? "Offline" : "Online",
                                fontSize: 12.sp,
                                color: showGrey
                                    ? AppColors.black4
                                    : AppColors.activeColor,
                              ),
                            ],
                            // Obx(
                            //   () => Text(
                            //     controller.isConnected.value
                            //         ? 'Online'
                            //         : 'Offline',
                            //     style: getTextStyle(
                            //       fontSize: 12.sp,
                            //       color: controller.isConnected.value
                            //           ? Colors.green
                            //           : Colors.white70,
                            //     ),
                            //   ),
                            // ),

                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final callID = DateTime.now().millisecondsSinceEpoch
                                .toString();
                            print("Video call tap!");
                            log(controller.userId);
                            log(name);
                            await ZegoUIKitPrebuiltCallInvitationService().send(
                              invitees: [ZegoCallUser(controller.userId, name)],
                              isVideoCall: true,
                              callID: callID,
                              timeoutSeconds: 30,
                            );
                            controller
                                    .socketController
                                    .currentCallPartnerId
                                    .value =
                                controller.userId;
                            controller.socketController.showError.value = true;

                            controller.sendCallNotification(
                              callType: true,
                              othersUserId: controller.userId,
                            );
                          },
                          child: SvgPicture.asset(
                            IconPath.videoCall,
                            color: AppColors.black3,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        InkWell(
                          onTap: () async {
                            // for audio call tap
                            final callID = DateTime.now().millisecondsSinceEpoch
                                .toString();
                            print("Audio call tap!");
                            log(controller.userId);
                            log(name);
                            await ZegoUIKitPrebuiltCallInvitationService().send(
                              invitees: [ZegoCallUser(controller.userId, name)],
                              isVideoCall: false,
                              callID: callID,
                              timeoutSeconds: 30,
                            );
                            controller
                                    .socketController
                                    .currentCallPartnerId
                                    .value =
                                controller.userId;
                            controller.socketController.showError.value = true;
                            controller.sendCallNotification(
                              callType: false,
                              othersUserId: controller.userId,
                            );
                          },

                          child: SvgPicture.asset(IconPath.audioCall),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                MediaQuery.of(context).size.width - 50,
                                100,
                                10,
                                0,
                              ),
                              items: [
                                // PopupMenuItem(
                                //   value: 'shear',
                                //   child: Row(
                                //     children: [
                                //       Icon(
                                //         Icons.share_rounded,
                                //         color: Colors.black54,
                                //       ),
                                //       SizedBox(width: 10.w),
                                //       CustomText(text: 'Shear user'),
                                //     ],
                                //   ),
                                // ),
                                PopupMenuItem(
                                  value: 'favorite',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: controller.isLiked.value
                                            ? Colors.red
                                            : Colors.black54,
                                      ),
                                      SizedBox(width: 10.w),
                                      CustomText(
                                        text: controller.isLiked.value
                                            ? 'Remove Favorite'
                                            : "Add Favorite",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).then((value) {
                              // if (value == 'shear') {
                              //   log('shear clicked');
                              // } else
                              if (value == 'favorite') {
                                log('favorite clicked');
                                controller.likeOrUnLiked();
                              }
                            });
                          },
                          child: Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// ================= MESSAGE BODY =================
            Positioned(
              top: getHeight(120),
              left: 0,
              right: 0,
              bottom: getHeight(0),
              child: Container(
                color: const Color(0xFFF9FAFB),
                padding: EdgeInsets.only(
                  bottom: getHeight(16),
                  left: getWidth(16),
                  right: getWidth(16),
                  top: 0,
                ),
                child: Obx(() {
                  if (controller.isUserLoading.value &&
                      controller.messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.messages.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No messages yet",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    reverse: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.messages.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      final isMe = msg.senderId == AuthService.id.toString();

                      return Padding(
                        padding: isMe == false
                            ? EdgeInsets.only(right: 50.w)
                            : EdgeInsets.only(left: 50.w),
                        child: MessageBubble(message: msg),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: getHeight(14),
                left: getWidth(14),
                right: getWidth(14),
                top: 0,
              ),
              child: Obx(() {
                if (controller.isUserLoading.value) {
                  return SizedBox.shrink();
                }
                // final isBlock = false;
                // final blockByMe = false;
                // if (isBlock == true) {
                //   if (blockByMe) {
                //     return GestureDetector(
                //       onTap: () {
                //         controller.unBlockUser(friendId: user2Id);
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(16.h),
                //         decoration: BoxDecoration(
                //           color: AppColors.primary,
                //           borderRadius: BorderRadius.circular(16),
                //         ),
                //         child: CustomText(
                //           text: "Unblock now",
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w600,
                //           textColor: AppColors.textWhite,
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                //     );
                //   } else {
                //     return CustomText(
                //       text: "This user has blocked you",
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.w400,
                //       textColor: AppColors.error,
                //       textAlign: TextAlign.center,
                //     );
                //   }
                // }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      if (controller.imagePath.value.isNotEmpty) {
                        return Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                CustomText(
                                  text: controller.imagePath.value
                                      .split("/")
                                      .last,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textWhite,
                                  textAlign: TextAlign.center,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      log("remove");
                                      controller.imagePath.value = "";
                                    },
                                    child: CustomText(
                                      text: "X",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textWhite,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    }),
                    Expanded(
                      child: CustomTextFormField(
                        onFieldSubmitted: (_) {
                          controller.sendSms(type: 'TEXT');
                        },
                        onChanged: (value) {
                          // controller.socketController.sendTyping(true);
                        },
                        controller: controller.messageController,
                        hintText: "Aa",
                        // containerColor: AppColors.textGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(
                            color: AppColors.textSecondary,
                          ),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.pickImage();
                          },
                          icon: Icon(
                            Icons.photo,
                            size: 24.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(width: getWidth(10)),
                    Obx(() {
                      if (controller.isLoadImage.value) {
                        return Container(
                          margin: EdgeInsets.only(top: getHeight(8)),
                          padding: EdgeInsets.all(getHeight(4)),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(getHeight(4)),
                            child: SizedBox(
                              height: getHeight(25),
                              width: getWidth(25),
                              child: CircularProgressIndicator(
                                color: AppColors.textWhite,
                              ),
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          controller.sendSms(type: 'TEXT');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(getHeight(8)),
                          child: Container(
                            padding: EdgeInsets.all(getHeight(10)),
                            decoration: BoxDecoration(
                              color: AppColors.bluePrimary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.near_me,
                              size: 24.sp,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
