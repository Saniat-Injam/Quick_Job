import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/controllers/apply_job_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/screens/resume_upload_screen.dart';

class UploadCVSection extends StatelessWidget {
  final VoidCallback onUploadTap;
  const UploadCVSection({super.key, required this.onUploadTap});

  @override
  Widget build(BuildContext context) {
    final ApplyJobController applyJobController =
        Get.find<ApplyJobController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload CV',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black3,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Add your CV/Resume to apply for a job',
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black4,
          ),
        ),
        SizedBox(height: 20.h),
        Obx(() {
          // If file is uploaded, show UploadFileCard
          // if (applyJobController.isFileUploaded.value &&
          //     applyJobController.selectedFile.value != null) {
          //   final file = applyJobController.selectedFile.value!;
          //   return UploadedFileCard(
          //     fileName: file.path.split('/').last,
          //     fileSize: '1.2 MB', // You can calculate actual size if needed
          //     fileDate:
          //         'Today', // You can use file.lastModifiedSync() for real date
          //     onRemove: () {
          //       applyJobController
          //           .removeFile(); // Implement removeFile in your controller
          //     },
          //   );
          // }

          // Otherwise, show upload box
          Color borderColor = applyJobController.errorMessage.isNotEmpty
              ? Colors.red
              : AppColors.dottedBorder;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                //onTap: onUploadTap,
                onTap: () {
                  Get.to(() => ResumeUploadScreen(userRole: '',));
                },
                borderRadius: BorderRadius.circular(8.r),
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: borderColor,
                    strokeWidth: 0.1,
                    dashPattern: const [6, 3],
                    strokeCap: StrokeCap.round,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(40.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(IconPath.upload),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: Text(
                            'Upload CV/Resume',
                            overflow: TextOverflow.ellipsis,
                            style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (applyJobController.errorMessage.isNotEmpty) ...[
                SizedBox(height: 6.h),
                Text(
                  applyJobController.errorMessage.value,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }
}
