import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/controllers/view_user_detail_controller.dart';
import 'package:quick_job/features/chat/models/get_employer_profile_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployerLayout extends StatelessWidget {
  const EmployerLayout({super.key, required this.controller});

  final ViewUserDetailController controller;

  @override
  Widget build(BuildContext context) {
    final employerData = controller.emplooyerProfileDetails.value;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.55,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                ((employerData.profileImage ?? "").isNotEmpty)
                    ? Image.network(
                        employerData.profileImage ?? "",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImagePath.appLogo,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        ImagePath.appLogo,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: _bodyData(
                employerData: employerData,
                controller: controller,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _bodyData({
  required EmployerDetailsProfile employerData,
  required ViewUserDetailController controller,
}) {
  final employerDetailData = employerData.employerProfile;
  // final cv =
  //     employerDetailData?.jobSeekersResume != null &&
  //         (employerDetailData?.jobSeekersResume ?? []).isNotEmpty
  //     ? employerDetailData?.jobSeekersResume?.first.resumeUrl
  //     : "";
  return SafeArea(
    top: false,
    bottom: true,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(24.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: employerData.fullName ?? "NA",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    IconPath.chat,
                    width: 26.w,
                    height: 26.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (employerData.isOnline == 0) ...[
              CustomText(
                text:
                    "Last online ${timeAgo(employerData.lastActivateAt ?? DateTime.now())}",
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

            SizedBox(height: 8.h),
            CustomText(
              text: employerDetailData?.companyAddress ?? "NA",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 22.h),
            Divider(color: AppColors.greySecondary),
            SizedBox(height: 22.h),
            CustomText(
              text: "About My company",
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            SizedBox(height: 12.h),
            // DefaultTextStyle(
            //   style: GoogleFonts.poppins(
            //     fontSize: 16.sp,
            //     color: Colors.white,
            //     fontWeight: FontWeight.w600,
            //   ),
            //   child: AnimatedTextKit(
            //     repeatForever: false,
            //     totalRepeatCount: 1,
            //     animatedTexts: [
            //       TypewriterAnimatedText(
            //         "Dis",
            //         speed: const Duration(milliseconds: 30),
            //         textStyle: GoogleFonts.poppins(
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.textSecondary,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: getHeight(5)),
            Divider(color: AppColors.greySecondary.withValues(alpha: 0.3)),
            SizedBox(height: getHeight(5)),
            _infoHelper(
              key: "Company Name",
              value: employerDetailData?.companyName ?? "NA",
            ),
            SizedBox(height: getHeight(10)),
            Divider(color: AppColors.greySecondary.withValues(alpha: 0.3)),
            SizedBox(height: getHeight(10)),
            _infoHelper(
              key: "Company Country",
              value: employerDetailData?.companyCountry ?? "NA",
            ),
            SizedBox(height: getHeight(5)),
            Divider(color: AppColors.greySecondary.withValues(alpha: 0.3)),
            SizedBox(height: getHeight(5)),
            _infoHelper(
              key: "Company Email",
              value: employerDetailData?.companyEmail ?? "NA",
            ),
            SizedBox(height: getHeight(5)),
            Divider(color: AppColors.greySecondary.withValues(alpha: 0.3)),
            SizedBox(height: getHeight(5)),
            _infoHelper(
              key: "Contract Number",
              value: employerData.phoneNumber ?? "NA",
            ),
            SizedBox(height: getHeight(5)),
            Divider(color: AppColors.greySecondary.withValues(alpha: 0.3)),
            SizedBox(height: getHeight(5)),
            _infoHelper(
              key: "Company Website",
              value: employerDetailData?.companyWebsite ?? "NA",
            ),
            SizedBox(height: getHeight(5)),
            Divider(color: AppColors.greySecondary.withValues(alpha: 0.3)),
            SizedBox(height: getHeight(5)),
            _infoHelper(
              key: "Company Zip Code",
              value: employerDetailData?.companyZipCode ?? "NA",
            ),
            SizedBox(height: getHeight(22)),
            Divider(color: AppColors.greySecondary),
            SizedBox(height: getHeight(22)),
            CustomText(
              text: "Company Intro video",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            SizedBox(height: getHeight(12)),
            (employerData.introVideo?.isNotEmpty ?? false)
                ? GetBuilder<ViewUserDetailController>(
                    builder: (controller) {
                      final videoController = controller.videoPlayerController;
                      final chewieController = controller.chewieController;

                      if (chewieController == null ||
                          videoController == null ||
                          !videoController.value.isInitialized) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: Chewie(controller: chewieController),
                        ),
                      );
                    },
                  )
                : const SizedBox(),

            // SizedBox(height: getHeight(22)),
            // Divider(color: AppColors.greySecondary),
            // SizedBox(height: getHeight(22)),
            // CustomText(
            //   text: "My CV",
            //   fontSize: 20.sp,
            //   fontWeight: FontWeight.w500,
            //   color: AppColors.textPrimary,
            // ),
            // SizedBox(height: getHeight(12)),

            // buildFileWidget(cv),
            SizedBox(height: getHeight(22)),
            Divider(color: AppColors.greySecondary),
            SizedBox(height: getHeight(22)),
            CustomText(
              text: "Gallery",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            SizedBox(height: 12.h),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final img =
                    employerData.gallaryImages?[index] ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTfyOxr6uHWJA3KYgH6nj3tZkSEDvnAg_2dA&s";
                return Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    // child: Image.network(img, fit: BoxFit.cover),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          ImagePath.dummyProfilePicture,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                );
              },
              itemCount: employerData.gallaryImages?.length,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _infoHelper({required String key, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: key,
        color: AppColors.textPrimary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      CustomText(
        text: value,
        color: AppColors.textSecondary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ],
  );
}

Widget buildFileWidget(String? fileUrl) {
  if (fileUrl == null || fileUrl.isEmpty) {
    return CustomText(
      text: "No file found",
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    );
  }

  final uri = Uri.parse(fileUrl);
  final extension = uri.path.split('.').last.toLowerCase();

  if (["jpg", "jpeg", "png", "gif", "bmp", "webp"].contains(extension)) {
    // It's an image
    return Image.network(
      fileUrl,
      errorBuilder: (context, error, stackTrace) {
        return CustomText(
          text: "Image not found",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        );
      },
    );
  } else if (["pdf"].contains(extension)) {
    // It's a PDF
    return GestureDetector(
      onTap: () {
        // Open PDF in browser or PDF viewer
        launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);
      },
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, color: Colors.red),
          SizedBox(width: 8),
          CustomText(
            text: "Open PDF",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  } else {
    // Other files (.doc, .docx, .txt, etc.)
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);
      },
      child: Row(
        children: [
          Icon(Icons.insert_drive_file, color: Colors.blue),
          SizedBox(width: 8),
          CustomText(
            text: "Open File",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
