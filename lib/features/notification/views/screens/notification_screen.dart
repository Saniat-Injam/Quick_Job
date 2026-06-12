import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/notification/controllers/notification_controller.dart';
import 'package:quick_job/features/notification/views/widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController notificationController = Get.put(
    NotificationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "Notifications",
              height: 90.h,
              backgroundColor: Colors.transparent,
              margin: 0.h,
            ),
            //SizedBox(height: 10.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  if (notificationController.isNotificationLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final notifications = notificationController.notifications;

                  if (notifications.isEmpty) {
                    return Center(
                      child: Text(
                        "No notifications yet.",
                        style: getTextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    //physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: notifications.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      return NotificationTile(data: item);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
