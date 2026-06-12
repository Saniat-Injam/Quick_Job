import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/chat/models/chat_message_model.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';

class ChatMessageTile extends StatelessWidget {
  final ChatMessageModel message;

  const ChatMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => IndividualChatScreen());
      },
      child: Container(
        color: AppColors.backgroundColor,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.only(left: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + Online Dot
            Stack(
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(message.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: message.isOnline
                          ? AppColors.green3
                          : AppColors.greySecondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.whitePrimary),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.sender,
                        style: getTextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        message.timestamp,
                        style: getTextStyle(
                          color: AppColors.dottedBorder,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    message.message,
                    style: getTextStyle(
                      color: AppColors.dottedBorder,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 9.5.h),

                  // Divider
                  Container(height: 1.h, color: AppColors.grey3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
