import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/employer_controller.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/post_card_widget.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';

class MyPostViewAllScreen extends StatelessWidget {
  final EmployerController controller = Get.find();

  MyPostViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Job Posts"),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshJobs,
        child: Obx(() {
          if (controller.isLoading.value && controller.allJobs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: controller.scrollController,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount:
                controller.filteredJobList.length +
                (controller.isPaginationLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.filteredJobList.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final job = controller.filteredJobList[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: PostCardWidget(
                  title: job['position'],
                  company: job['companyName'],
                  location: job['location'],
                  status: job['status'],
                  salary: job['salary'].toString(),
                  image: job['logo'] ?? ImagePath.floydMiles,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
