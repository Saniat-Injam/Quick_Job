import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/custom_search_bar.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/controllers/home_controller.dart';
import 'package:quick_job/features/job_seeker_flow/search/controllers/search_result_job_controller.dart';

import 'package:quick_job/features/job_seeker_flow/search/views/widgets/search_result_job_card.dart';

class SearchScreen extends StatelessWidget {
  final SearchResultJobController controller = Get.put(
    SearchResultJobController(),
  );

  final TextEditingController textController = TextEditingController();
  final HomeController homeController;

  SearchScreen({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CustomAppBar(title: 'Search',),
            CustomAppBar(
              title: "Search Jobs",
              height: 120.h,
              backgroundColor: Colors.transparent,
              margin: 0.h,
              spacing: 0.h,
            ),
            // 🔍 Search Box
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: const Color(0xFFD1D6DB)),
            //     borderRadius: BorderRadius.circular(8),
            //     color: Colors.white,
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: textController,
            //           onChanged: controller.searchJob,
            //           decoration: const InputDecoration(
            //             hintText: 'Search...',
            //             enabledBorder: InputBorder.none,
            //             focusedBorder: InputBorder.none,
            //             isDense: true,
            //           ),
            //         ),
            //       ),
            //       SvgPicture.asset(IconPath.search),
            //     ],
            //   ),
            // ),
            CustomSearchBar(
              controller: textController,
              onFieldSubmitted: (value) {
                homeController.searchJobs(value.toString());
              },
              onclick: () {
                homeController.searchJobs(textController.text.toString());

                log("Clcik");
              },
              // onChanged: (value) {
              //   controller.searchJob(value);
              // },
            ),

            SizedBox(height: 12.h),

            // 🔄 Search Results
            Expanded(
              child: Obx(() {
                if (homeController.isJobLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (homeController.jobs.isEmpty) {
                  return Center(
                    child: Image.asset(
                      LogoPath.noResultFound,
                      width: 156.32.w,
                      height: 176.82.h,
                    ),
                  );
                  // return Center(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       SizedBox(height: 70.h),
                  //       Image.asset(
                  //         LogoPath.noResultFound,
                  //         width: 156.32.w,
                  //         height: 176.82.h,
                  //       ),
                  //       SizedBox(height: 40.h),
                  //       Text(
                  //         'No results found',
                  //         textAlign: TextAlign.center,
                  //         style: getTextStyle(
                  //           fontSize: 16.sp,
                  //           color: Colors.black54,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       SizedBox(height: 16.h),
                  //       Text(
                  //         'The search could not be found,\nplease check spelling or write another word.',
                  //         textAlign: TextAlign.center,
                  //         style: getTextStyle(
                  //           fontSize: 14.sp,
                  //           color: Colors.black54,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: homeController.jobs.length,
                  itemBuilder: (context, index) {
                    final jobs = homeController.jobs[index];
                    return SearchResultJobCard(job: jobs);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
