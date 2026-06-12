import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/features/chat/controllers/view_user_detail_controller.dart';
import 'package:quick_job/features/chat/views/widgets/employer_layout.dart';
import 'package:quick_job/features/chat/views/widgets/job_seeker_layout.dart';

class ViewUserDetailsScreen extends StatelessWidget {
  ViewUserDetailsScreen({super.key});

  final controller = Get.find<ViewUserDetailController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.cleanUpController();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Profile details",
          onTap: () {
            controller.cleanUpController();
            Get.back();
          },
        ),
        body: Obx(() {
          if (controller.isUserLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.detailUserRole.value == "JOB_SEEKERS") {
            return JobSeekerLayout(controller: controller);
          }
          return EmployerLayout(controller: controller);
        }),
      ),
    );
  }
}
