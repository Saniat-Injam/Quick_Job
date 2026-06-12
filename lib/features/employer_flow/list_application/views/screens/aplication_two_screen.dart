import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/aplication_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/edit_job_post_detail_screen.dart';

class AplicationTwoScreen extends StatefulWidget {
  const AplicationTwoScreen({
    super.key,
    required this.candidateName,
    required this.candidatePosition,
    required this.candidateImage,
    required this.resumeUrl,
    required this.jobApplyId,
  });

  final String candidateName;
  final String candidatePosition;
  final String candidateImage;
  final String resumeUrl;
  final String jobApplyId;

  @override
  State<AplicationTwoScreen> createState() => _AplicationTwoScreenState();
}

class _AplicationTwoScreenState extends State<AplicationTwoScreen> {
  final controller = Get.find<AplicationController>();
  final timeController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.bluePrimary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Format date as yyyy-MM-dd
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.pickaDate.text = formattedDate;
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.bluePrimary),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );

    if (pickedTime != null) {
      // Format time in 24-hour format as HH:mm
      final hour = pickedTime.hour.toString().padLeft(2, '0');
      final minute = pickedTime.minute.toString().padLeft(2, '0');
      final formattedTime = '$hour:$minute';
      timeController.text = formattedTime;
    }
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 36.0.h, left: 10.0.w, right: 10.0.w),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: "Applicants",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Container(
              padding: EdgeInsets.all(16.0.h),
              decoration: BoxDecoration(
                color: AppColors.whitePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: widget.candidateImage.isNotEmpty
                          ? NetworkImage(widget.candidateImage) as ImageProvider
                          : AssetImage(ImagePath.floydMiles) as ImageProvider,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.candidateName,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        CustomText(
                          text: widget.candidatePosition,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.textFormFieldBorder),
                  SizedBox(height: 16.h),
                  CustomSubmitButton(
                    text: "See Resume",
                    onTap: () {
                      if (widget.resumeUrl.isNotEmpty) {
                        // Get.to(() => SeeResumeScreen(pdfUrl: widget.resumeUrl));

                        openFileExternally(fileUrl: widget.resumeUrl);
                      } else {
                        AppSnackBar.showError(
                          "Resume not available for this candidate.",
                        );
                      }
                    },
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  SizedBox(height: 12.h),
                  CustomTextFormField(
                    controller: controller.pickaDate,
                    hintText: "Schedule to Interview",
                    containerBorderWidth: 1,
                    containerBorderColor: AppColors.bluePrimary,
                    hintTextStyle: getTextStyle(
                      color: AppColors.bluePrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    readonly: true,
                    suffixIcon: IconButton(
                      onPressed: _pickDate,
                      icon: Icon(
                        CupertinoIcons.calendar,
                        color: AppColors.bluePrimary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.textFormFieldBorder),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: timeController,
                    hintText: "Hour",
                    containerBorderWidth: 1,
                    containerBorderColor: AppColors.bluePrimary,
                    hintTextStyle: getTextStyle(
                      color: AppColors.bluePrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    readonly: true,
                    suffixIcon: IconButton(
                      onPressed: _pickTime,
                      icon: Icon(
                        CupertinoIcons.clock,
                        color: AppColors.bluePrimary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.textFormFieldBorder),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: requeidRichTect(text: "Message"),
                  ),
                  CustomTextFormField(
                    controller: controller.messageController,
                    hintText: "Message",
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          top: 20.0.h,
          left: 16.w,
          right: 16.w,
          bottom: 34.h,
        ),
        child: Obx(
          () => CustomSubmitButton(
            text: controller.isSubmitting.value
                ? "Sending..."
                : "Send to Applicants",
            onTap: controller.isSubmitting.value
                ? () {}
                : () async {
                    if (controller.pickaDate.text.isEmpty) {
                      AppSnackBar.showError("Please select an interview date");
                      return;
                    }

                    if (timeController.text.isEmpty) {
                      AppSnackBar.showError("Please select an interview time");
                      return;
                    }

                    // Submit the application status
                    final success = await controller.submitApplicationStatus(
                      jobApplyId: widget.jobApplyId,
                      status: 'ACCEPT', // Interview = ACCEPT
                      message: controller.messageController.text,
                      interviewDate: controller.pickaDate.text,
                      interviewTime: timeController.text,
                    );

                    if (success) {
                      bottomSheetEdit();
                    } else {
                      AppSnackBar.showError(
                        "Failed to send interview invitation",
                      );
                    }
                  },
            color: AppColors.bluePrimary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

void bottomSheetEdit() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImagePath.confirmImg,
            height: 250.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: "Successful!",
            fontSize: 30.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bluePrimary,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          CustomText(
            text: "Notifications have been sent to applicants.",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGrey,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          CustomSubmitButton(
            text: "Ok",
            onTap: () {
              Get.back();
              Get.back();
              Get.back(); // Go back to the application list
            },
            borderRadius: BorderRadius.circular(10),
            color: AppColors.bluePrimary,
          ),
          SizedBox(height: 26.h),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
