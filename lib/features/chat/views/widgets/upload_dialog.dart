import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/chat/controllers/upload_controller.dart';

class UploadDialog extends StatelessWidget {
  const UploadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadController>();

    return Dialog(
      backgroundColor: AppColors.whitePrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header row (title + close)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload',
                  style: getTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: AppColors.black4),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            /// Upload options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Open Gallery
                Column(
                  children: [
                    InkWell(
                      onTap: controller.openGallery,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8.r),
                        ),

                        child: SvgPicture.asset(
                          IconPath.openGallery,
                          width: 40.sp,
                          height: 40.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Open Gallery',
                      style: getTextStyle(
                        color: AppColors.bluePrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                /// Open File
                Column(
                  children: [
                    InkWell(
                      onTap: controller.openFile,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8.r),
                        ),

                        child: SvgPicture.asset(
                          IconPath.openFile,
                          width: 40.sp,
                          height: 40.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Open File',
                      style: getTextStyle(
                        color: AppColors.black4,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
