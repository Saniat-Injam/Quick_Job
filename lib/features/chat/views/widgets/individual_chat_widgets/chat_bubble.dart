import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/models/individual_chat_message_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == AuthService.id.toString();
    final bgColor = isMe
        ? (message.imageUrl ?? "").isEmpty
              ? Color(0xFF0E55FD)
              : Color(0xFF0E55FD).withValues(alpha: 0.8)
        : AppColors.textFormFieldBorder.withValues(alpha: 0.5);
    final textColor = isMe ? Colors.white : Color(0xFF2D2D2D);
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final messageStatus = message.messageStatus;
    // final readMessage = message
    final radius = BorderRadius.only(
      topLeft: Radius.circular(20.r),
      topRight: Radius.circular(20.r),
      bottomLeft: isMe ? Radius.circular(20.r) : Radius.circular(4.r),
      bottomRight: isMe ? Radius.circular(4.r) : Radius.circular(20.r),
    );

    return message.messageType == "TEXT"
        ? Column(
            crossAxisAlignment: align,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: radius,
                  boxShadow: isMe
                      ? null
                      : [
                          BoxShadow(
                            color: Color(0x051370B1),
                            blurRadius: 50.r,
                            offset: Offset(0, 10.h),
                          ),
                        ],
                ),

                child: Stack(
                  children: [
                    // MESSAGE TEXT
                    Padding(
                      padding: EdgeInsets.only(
                        right: isMe ? 50.w : 30.w,
                        bottom: 20.h,
                      ),
                      child: (message.imageUrl ?? "").isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    message.imageUrl ?? "",
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return CircularProgressIndicator();
                                        },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        ImagePath.appLogo,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: getHeight(5)),
                                Text(
                                  message.content ?? "",
                                  textAlign: TextAlign.left,
                                  style: getTextStyle(
                                    color: textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              message.content ?? "NA",
                              textAlign: isMe
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: getTextStyle(
                                color: textColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                    ),

                    // TIME + TICK (BOTTOM RIGHT)
                    Positioned(
                      bottom: 0,
                      right: isMe ? 0 : null,
                      left: isMe ? null : 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            // _formatTime(message.createdAt ?? DateTime.now()),
                            timeAgo(message.createdAt ?? DateTime.now()),
                            style: getTextStyle(
                              color: isMe
                                  ? AppColors.textWhite.withValues(alpha: 0.6)
                                  : Color(0xFF757575).withValues(alpha: 0.6),
                              fontSize: 11.sp,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          if (isMe) ...[
                            SizedBox(width: 4.w),
                            if (messageStatus == "send") ...[
                              Icon(
                                Icons.done,
                                size: 16.sp,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w900,
                              ),
                            ] else if (messageStatus == "seen") ...[
                              Icon(
                                Icons.done_all,
                                size: 16.sp,
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w900,
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
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: align,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFFF3E8FF),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: message.content != "0"
                                ? AppColors.bluePrimary.withValues(alpha: 0.7)
                                : Colors.red.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            message.messageType == "AUDIO"
                                ? Icons.call
                                : Icons.video_call,
                            size: 24.sp,
                            color: AppColors.textWhite,
                          ),
                        ),
                        SizedBox(width: getWidth(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: message.messageType == "AUDIO"
                                  ? "Audio call"
                                  : "Video call",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: message.content != "0"
                                  ? AppColors.bluePrimary
                                  : Colors.red,
                            ),
                            CustomText(
                              text: message.content != "0"
                                  ? "${(int.tryParse(message.content ?? "0") ?? 0) ~/ 60}m "
                                        "${(int.tryParse(message.content ?? "0") ?? 0) % 60}s"
                                  : "Missed call",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: message.content != "0"
                                  ? AppColors.bluePrimary
                                  : Colors.red,
                            ),
                            Text(
                              // _formatTime(message.createdAt ?? DateTime.now()),
                              timeAgo(message.createdAt ?? DateTime.now()),
                              style: getTextStyle(
                                fontWeight: FontWeight.w400,
                                color: message.content != "0"
                                    ? AppColors.bluePrimary
                                    : Colors.red,
                                fontSize: 8.sp,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  // String _formatTime(DateTime t) {
  //   final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
  //   final minute = t.minute.toString().padLeft(2, '0');
  //   final ampm = t.hour >= 12 ? 'pm' : 'am';
  //   return '$hour:$minute $ampm';
  // }
}
