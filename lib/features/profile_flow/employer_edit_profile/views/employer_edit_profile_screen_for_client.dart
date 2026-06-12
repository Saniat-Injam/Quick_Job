import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_outline_button.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/controllers/employer_edit_profile_controller_for_client.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/widgets/company_addres.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/widgets/company_information.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/widgets/employer_personal_info.dart';

class EmployerEditProfileScreenForClient
    extends GetView<EmployerEditProfileControllerForClient> {
  const EmployerEditProfileScreenForClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.currentIndex.value == 0) {
              return Padding(
                padding: EdgeInsets.all(getHeight(16)),
                child: EmployerPersonalInfo(controllerForClient: controller),
              );
            }
            if (controller.currentIndex.value == 1) {
              return Padding(
                padding: EdgeInsets.all(getHeight(2)),
                child: CompanyInformation(controllerForClient: controller),
              );
            }
            return Padding(
              padding: EdgeInsets.all(getHeight(2)),
              child: CompanyAddres(controllerForClient: controller),
            );
          }),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getHeight(16)),
          child: Obx(
            () => Row(
              children: [
                if (controller.currentIndex.value > 0) ...[
                  Expanded(
                    child: CustomOutlineButton(
                      text: "Back",
                      onPressed: () {
                        log("Back");
                        controller.back();
                      },
                      borderColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: getWidth(20)),
                ],

                Expanded(
                  child: CustomSubmitButton(
                    text: controller.currentIndex.value == 2
                        ? "Complete"
                        : "Next",
                    onTap: () {
                      log("Next or completed");
                      controller.next();
                    },
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
