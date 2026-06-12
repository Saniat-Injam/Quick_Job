import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_dropdown.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/custom_input_field.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/validators/app_validator.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller.dart';

class EmployerEditProfileScreen extends StatelessWidget {
  EmployerEditProfileScreen({super.key});

  final EmployerEditProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: 'Edit Profile',
                  backgroundColor: AppColors.transparent,
                  padding: EdgeInsets.zero,
                ),

                SizedBox(height: 20.h),

                CustomInputField(
                  label: 'Your name',
                  //hint: "AirBNB",
                  hint: "Enter your name",
                  isRequired: true,
                  controller: controller.yourNameController,
                  validator: AppValidator.validateNotEmpty,
                ),
                SizedBox(height: 20.h),
                CustomInputField(
                  label: 'Your Phone number',
                  //hint: "AirBNB",
                  hint: "Enter your phone number",
                  isRequired: true,
                  controller: controller.phoneNumberController,
                  validator: AppValidator.validateNotEmpty,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h),

                CustomInputField(
                  label: 'Name of Company',
                  //hint: "AirBNB",
                  hint: "Enter your company name",
                  isRequired: true,
                  controller: controller.companyNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Company name is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 19.h),
                CustomText(
                  text: 'What is your role in this company?',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackSecondary,
                ),

                // const SizedBox(height: 16),
                Obx(
                  () => CustomDropdownField(
                    hintText: "Owner",
                    items: controller.companyRole,
                    selectedValue: controller
                        .selctedCompanyRole
                        .value, // This should be a String
                    onChanged: controller.changeCompanyRole,
                  ),
                ),

                SizedBox(height: 19.h),

                CustomInputField(
                  label: 'Company Email',
                  hint: "airbnb@yourdomain.com",
                  //hint: "Enter your company's email",
                  isRequired: true,
                  controller: controller.emailController,
                  validator: AppValidator.validateEmail,
                ),

                SizedBox(height: 19.h),
                CustomInputField(
                  label: 'Company Phone Number',
                  hint: 'Enter Company Phone Number',
                  controller: controller.companyPhoneTEController,
                  validator: AppValidator.validateNotEmpty,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                ),
                SizedBox(height: 19.h),
                CustomInputField(
                  label: 'Website',
                  hint: 'Enter Website',
                  controller: controller.websiteTEController,
                  validator: AppValidator.validateNotEmptyWithAll,
                  isRequired: true,
                ),
                SizedBox(height: 19.h),
                CustomInputField(
                  label: 'Zip Code',
                  hint: 'Enter Zip Code',
                  controller: controller.zipCodeTEController,
                  validator: AppValidator.validateNotEmpty,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                ),
                SizedBox(height: 19.h),
                CustomInputField(
                  label: 'Description',
                  hint: 'Enter Description',
                  controller: controller.descriptionTEController,
                  validator: AppValidator.validateNotEmptyWithAll,
                  isRequired: true,
                ),
                SizedBox(height: 19.h),

                CustomInputField(
                  label: 'Established Date',
                  hint: "25-08-2015",
                  isRequired: true,
                  controller: controller.establishedDateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      //lastDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.blue, // Header background
                              onPrimary: Colors.white, // Header text color
                              onSurface: Colors.black, // Date numbers
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Colors.red, // Button text color
                              ),
                            ),
                            textTheme: TextTheme(
                              headlineMedium: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ), // Month/Year font
                              titleMedium: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ), // Weekday labels
                              bodyMedium: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ), // Date numbers
                            ),
                            dialogTheme: DialogThemeData(
                              backgroundColor: Colors.grey[100],
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      controller.establishedDateController.text =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Established date is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 19.h),
                // 2. Country Picker
                CustomInputField(
                  label: 'Country',
                  hint: "United States",
                  isRequired: true,
                  controller: controller.countryController,
                  readOnly: true,
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        controller.countryController.text = country.name;
                      },
                      countryListTheme: CountryListThemeData(
                        flagSize: 25, // flag size
                        backgroundColor: Colors.white, // picker background
                        textStyle: getTextStyle(
                          fontSize: 16, // country font size
                          color: Colors.black,
                          fontWeight: FontWeight.w400, // country font color
                        ),
                        bottomSheetHeight: 500, // picker height
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        inputDecoration: InputDecoration(
                          labelText: 'Search Country',
                          labelStyle: getTextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          hintText: 'Type country name',
                          hintStyle: getTextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 19.h),

                CustomInputField(
                  label: 'Company Address',
                  hint: "President Grand Avenue 001",
                  isRequired: true,
                  controller: controller.addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 19.h),

                CustomText(
                  text: "Upload Video",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),

                Obx(() {
                  if (controller.isVideo.value) {
                    return GestureDetector(
                      onTap: () {
                        log("upload video");
                        controller.pickVideo();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textFormFieldBorder,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            // 📄 Video path text
                            Padding(
                              padding: const EdgeInsets.only(right: 32),
                              child: CustomText(
                                text:
                                    "📸 You have already upload a Video For change this tap here!",
                                maxLines: 2,
                                color: AppColors.greenPrimary,
                              ),
                            ),

                            // Positioned(
                            //   top: 0,
                            //   right: 0,
                            //   child: InkWell(
                            //     onTap: () {
                            //       updateProfileController.videoPath.value =
                            //           null;
                            //     },
                            //     child: Container(
                            //       padding: const EdgeInsets.all(4),
                            //       decoration: BoxDecoration(
                            //         color: AppColors.primary.withOpacity(0.1),
                            //         shape: BoxShape.circle,
                            //       ),
                            //       child: const Icon(Icons.close, size: 16),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (controller.videoPath.value != null) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textFormFieldBorder,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          // 📄 Video path text
                          Padding(
                            padding: const EdgeInsets.only(right: 32),
                            child: CustomText(
                              text: controller.videoPath.value!.path,
                              maxLines: 2,
                            ),
                          ),

                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                controller.videoPath.value = null;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      log("upload video");
                      controller.pickVideo();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 36.h,
                        bottom: 36.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textFormFieldBorder,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Upload your video",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey4,
                        ),
                      ),
                    ),
                  );
                }),

                SizedBox(height: 32.h),

                Obx(
                  () => CustomButton(
                    text: controller.isUpdatingProfile.value
                        ? "Updating..."
                        : "Update",
                    onPressed: controller.updateProfile,
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
