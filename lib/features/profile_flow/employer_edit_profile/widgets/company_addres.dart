import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/customContiner.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller_for_client.dart';

class CompanyAddres extends StatelessWidget {
  const CompanyAddres({super.key, required this.controllerForClient});

  final EmployerEditProfileControllerForClient controllerForClient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CustomContiner(
        //   child: Column(
        //     children: [
        //       CustomText(
        //         text: "Company intro video",
        //         fontSize: 18.sp,
        //         fontWeight: FontWeight.w600,
        //       ),
        //       SizedBox(height: getHeight(8)),
        //       CustomText(
        //         text: "This will help candidates identify your brand quickly!",
        //         fontSize: 12.sp,
        //         fontWeight: FontWeight.w400,
        //         color: AppColors.textSecondary,
        //       ),
        //       SizedBox(height: getHeight(10)),
        //       SizedBox(width: getWidth(20)),
        //       Obx(() {
        //         if (controllerForClient.videoName.value.isNotEmpty) {
        //           return GestureDetector(
        //             onTap: () {
        //               log("Change video");

        //               controllerForClient.pickVideo();
        //             },
        //             child: CustomContiner(
        //               child: Row(
        //                 children: [
        //                   Icon(
        //                     Icons.video_call,
        //                     size: 24.sp,
        //                     color: AppColors.bluePrimary,
        //                   ),
        //                   SizedBox(width: getWidth(10)),
        //                   CustomText(
        //                     text: controllerForClient.videoName.value,
        //                     fontSize: 14.sp,
        //                     fontWeight: FontWeight.w400,
        //                     color: AppColors.bluePrimary,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             // child: ClipRRect(
        //             //   borderRadius: BorderRadius.circular(8),
        //             //   child: Image.file(
        //             //     controllerForClient.selectedCompanyLogoImage.value!,
        //             //     height: getHeight(50),
        //             //     width: double.infinity,
        //             //     fit: BoxFit.cover,
        //             //   ),
        //             // ),
        //           );
        //         }
        //         return CustomDottetContiner(
        //           text: "Select your company intro video",
        //           onTap: () {
        //             log("Click for company intro video");
        //             controllerForClient.pickVideo();
        //           },
        //         );
        //       }),
        //     ],
        //   ),
        // ),
        // SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Company Location",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Company address",
                hint: "Enter company address",
                controller: controllerForClient.companyAddressController,
              ),
              SizedBox(height: getHeight(10)),
              Divider(color: AppColors.textGrey.withAlpha(50)),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Zip code",
                hint: "Enter zip code",
                controller: controllerForClient.companyZipCodeController,
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(height: getHeight(10)),
              Divider(color: AppColors.textGrey.withAlpha(50)),
              SizedBox(height: getHeight(10)),
              CustomText(
                text: "Company country",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: getHeight(10)),
              CustomTextFormField(
                controller: controllerForClient.companyCountryController,
                suffixIcon: GestureDetector(
                  onTap: () {
                    controllerForClient.pickCountry(context);
                  },
                  child: const Icon(Icons.location_on),
                ),
                hintText: 'Select country/region',
              ),
            ],
          ),
        ),
        SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Company social side",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "Company website",
                hint: "www.example.com",
                controller: controllerForClient.companyWebsiteController,
              ),
            ],
          ),
        ),
        SizedBox(height: getHeight(20)),
        CustomContiner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Company short details",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeight(10)),
              CustomInputField(
                label: "About your company",
                hint: "Enter you company details....",
                controller: controllerForClient.companyDescController,
                maxLine: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
