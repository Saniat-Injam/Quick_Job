import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/customContiner.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller_for_client.dart';

class CompanyInformation extends StatelessWidget {
  const CompanyInformation({super.key, required this.controllerForClient});

  final EmployerEditProfileControllerForClient controllerForClient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CustomContiner(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             CustomText(
        //               text: "Company logo",
        //               fontSize: 18.sp,
        //               fontWeight: FontWeight.w600,
        //             ),
        //             SizedBox(height: getHeight(8)),
        //             CustomText(
        //               text:
        //                   "This will help candidates identify your brand quickly!",
        //               fontSize: 12.sp,
        //               fontWeight: FontWeight.w400,
        //               color: AppColors.textSecondary,
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(width: getWidth(20)),
        //       Obx(() {
        //         if (controllerForClient.selectedCompanyLogoImage.value !=
        //             null) {
        //           return GestureDetector(
        //             onTap: () {
        //               log("Change image");

        //               controllerForClient.pickImageForCompanyLogo();
        //             },
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(8),
        //               child: Image.file(
        //                 controllerForClient.selectedCompanyLogoImage.value!,
        //                 height: getHeight(70),
        //                 width: getWidth(70),
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           );
        //         }
        //         return CustomDottetContiner(
        //           onTap: () {
        //             log("Click for company logo");
        //             controllerForClient.pickImageForCompanyLogo();
        //           },
        //         );
        //       }),
        //     ],
        //   ),
        // ),
        SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Company Information",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Company name",
                hint: "Enter company name",
                controller: controllerForClient.companyNameController,
              ),
              SizedBox(height: getHeight(10)),
              Divider(color: AppColors.textGrey.withAlpha(50)),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Company email",
                hint: "Enter company email",
                controller: controllerForClient.companyEmailController,
              ),
              SizedBox(height: getHeight(10)),
              Divider(color: AppColors.textGrey.withAlpha(50)),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Company phone number",
                hint: "Enter company phone number",
                controller: controllerForClient.companyPhoneController,
                keyboardType: TextInputType.numberWithOptions(),
              ),
              // SizedBox(height: getHeight(10)),
              // Divider(color: AppColors.textGrey.withAlpha(50)),
              // SizedBox(height: getHeight(10)),
              // CustomInputField(
              //   label: "Type of business",
              //   hint: "What is type of your business?",
              //   controller: controllerForClient.companyBuisnessType,
              // ),
              SizedBox(height: getHeight(10)),
              Divider(color: AppColors.textGrey.withAlpha(50)),
              SizedBox(height: getHeight(10)),
              CustomText(
                text: "Company establish date",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: getHeight(10)),
              CustomTextFormField(
                controller: controllerForClient.companyDateController,
                hintText: "Establishment Date",
                readonly: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    controllerForClient.pickDate(context);
                  },
                  child: const Icon(Icons.calendar_month_rounded),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
