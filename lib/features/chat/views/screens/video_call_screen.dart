import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/chat/controllers/video_call_controller.dart';
import 'package:quick_job/features/chat/models/video_call_model.dart';

class VideoCallScreen extends StatelessWidget {
  final VideoCallModel callModel;

  const VideoCallScreen({super.key, required this.callModel});

  @override
  Widget build(BuildContext context) {
    final VideoCallController videoCallController = Get.find();
    videoCallController.initCall(callModel);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: callModel.backgroundAsset != null
                ? Image.asset(callModel.backgroundAsset!, fit: BoxFit.cover)
                : const SizedBox.shrink(),
          ),

          // Blur overlay
          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 12.r, sigmaY: 12.r),
          //     child: Container(color: Colors.black.withValues(alpha: 0.4)),
          //   ),
          // ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 24.h),

                // Profile section
                Column(
                  children: [
                    CircleAvatar(
                      radius: 52.r,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 48.r,
                        backgroundImage: callModel.avatarAsset != null
                            ? AssetImage(callModel.avatarAsset!)
                            : null,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      callModel.name,
                      style: getTextStyle(
                        color: AppColors.whitePrimary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      callModel.phone,
                      style: getTextStyle(
                        color: AppColors.whitePrimary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                // Timer pill
                Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      videoCallController.formattedTime,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),

                // Controls
                Padding(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Mic
                      Obx(
                        () => _buildControl(
                          onTap: videoCallController.toggleMute,
                          icon: videoCallController.isMuted.value
                              ? Icons.mic_off
                              : Icons.mic,
                          active: videoCallController.isMuted.value,
                        ),
                      ),
                      SizedBox(width: 18.w),

                      // Speaker
                      Obx(
                        () => _buildControl(
                          onTap: videoCallController.toggleSpeaker,
                          icon: videoCallController.isSpeaker.value
                              ? Icons.volume_up
                              : Icons.volume_off,
                          active: videoCallController.isSpeaker.value,
                        ),
                      ),
                      SizedBox(width: 18.w),

                      // End call
                      _buildControl(
                        onTap: videoCallController.endCall,
                        icon: Icons.call_end,
                        active: true,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControl({
    required VoidCallback onTap,
    required IconData icon,
    bool active = false,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    final bg =
        backgroundColor ??
        (active ? Colors.white : Colors.white.withOpacity(0.9));
    final ic = iconColor ?? (active ? Colors.black87 : Colors.black87);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, color: ic, size: 28.sp),
        ),
      ),
    );
  }
}
