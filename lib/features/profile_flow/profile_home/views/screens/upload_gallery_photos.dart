import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/profile_home/controllers/upload_gallary_photos_controller.dart';
import 'package:quick_job/features/profile_flow/profile_home/popup/previewImage_popup.dart';

class UploadGalleryPhoto extends StatelessWidget {
  UploadGalleryPhoto({super.key});

  final controller = Get.find<UploadGalleryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Upload Photo"),
      body: Padding(
        padding: EdgeInsets.all(getHeight(20)),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.4,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(getHeight(8)),
              child: _uploadImg(controller: controller, index: index),
            );
          },
          itemCount: 5,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getHeight(20)),
          child: Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  text: "Back",
                  onPressed: () {
                    log("back hit");
                    // controller.uploadImg();
                    Get.back();
                  },
                ),
              ),
              SizedBox(width: getWidth(20)),
              Expanded(
                child: CustomSubmitButton(
                  text: "Preview",
                  onTap: () {
                    final gallayImg = AuthService.role == "EMPLOYEER"
                        ? controller
                                  .employerHomeController
                                  .employerProfileData
                                  .value
                                  .gallaryImages ??
                              []
                        : controller
                                  .jobSeekerHomeController
                                  .jobSeekerProfile
                                  .value
                                  .gallaryImages ??
                              [];
                    previewImage(
                      imageList: gallayImg.isNotEmpty ? gallayImg : [],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _uploadImg({
  required UploadGalleryController controller,
  required int index,
}) {
  log("Image url is : ${controller.imageList[index]}");
  return Obx(
    () => Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: AppColors.secondary.withAlpha(100),
            child:
                controller.imageList[index] != null &&
                    (controller.imageList[index] ?? "").isNotEmpty
                ? (controller.imageList[index] ?? "").startsWith("http")
                      ? Image.network(
                          controller.imageList[index]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                        )
                      : null
                : null,
          ),
        ),

        // Add Icon
        Positioned(
          right: getWidth(10),
          bottom: getHeight(10),
          child: GestureDetector(
            onTap: () {
              log("Image url is : ${controller.imageList[index] ?? ""}");
              controller.pickImage(
                index,
                controller.imageList[index].toString(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withAlpha(150),
              ),
              child: Icon(
                (controller.imageList[index] ?? "").startsWith("http")
                    ? Icons.edit
                    : Icons.add,
                size: 14.sp,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ),
        // delete Icon
        if ((controller.imageList[index] ?? "").startsWith("http")) ...[
          Positioned(
            left: getWidth(10),
            bottom: getHeight(10),
            child: GestureDetector(
              onTap: () {
                log("delete hit");
                deleteGalleryImg(controller: controller, index: index);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withAlpha(150),
                ),
                child: Icon(
                  CupertinoIcons.delete,
                  size: 14.sp,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

void deleteGalleryImg({
  required UploadGalleryController controller,
  required int index,
}) {
  Get.bottomSheet(
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Delete",
            fontSize: 26.sp,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
          SizedBox(height: getHeight(24)),
          CustomText(
            text: "Are you sure you want to Delete this image?",
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
          ),

          SizedBox(height: getHeight(34)),
          Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: "No, Later",
                  borderColor: AppColors.primary,
                ),
              ),
              SizedBox(width: getWidth(20)),
              Expanded(
                child: CustomSubmitButton(
                  text: "Yes, Delete",
                  onTap: () {
                    Future.microtask(() async {
                      Get.back();
                      await Future.delayed(const Duration(milliseconds: 200));
                      if (Get.isDialogOpen == false) {
                        controller.deleteAImg(index: index);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: getHeight(34)),
        ],
      ),
    ),
    isDismissible: true,
    enableDrag: true,
  );
}
