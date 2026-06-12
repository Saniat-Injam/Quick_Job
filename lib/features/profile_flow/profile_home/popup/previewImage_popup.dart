import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/image_preview_controller.dart';

void previewImage({required List imageList}) {
  final controller = Get.find<ImagePreviewController>();
  Get.bottomSheet(
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.cancel, size: 24.sp, color: AppColors.primary),
          ),
          SizedBox(height: getHeight(18)),
          SizedBox(
            width: double.infinity,
            child: CustomText(
              text: "Preview",
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: getHeight(24)),
          if (imageList.isNotEmpty) ...[
            SizedBox(
              height: getHeight(500),
              child: PageView.builder(
                itemCount: imageList.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final img = imageList[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      img,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator();
                      },
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: CustomText(
                text: "No photo for preview",
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ),
          ],

          SizedBox(height: getHeight(24)),
          if (imageList.isNotEmpty) ...[
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentIndex.value == index ? 12 : 10,
                    height: controller.currentIndex.value == index ? 12 : 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex.value == index
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ],

          SizedBox(height: getHeight(54)),
        ],
      ),
    ),
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
  );
}
