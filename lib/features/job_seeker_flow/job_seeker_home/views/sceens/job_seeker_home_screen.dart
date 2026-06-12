import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/gobel_checkmark_indicator.dart';
import 'package:quick_job/core/custom/my_widgets/custom_search_bar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';
import 'package:quick_job/features/job_seeker_flow/job_details/views/screens/job_details_screen.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/controllers/home_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/widgets/custom_category_tile.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/widgets/for_job_seeker_job_filter.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/views/widgets/nearby_job_card.dart';
import 'package:quick_job/features/notification/views/screens/notification_screen.dart';

class HomeScreen extends GetView<HomeController> {
  final String userRole;

  const HomeScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    // final HomeController homeController = Get.put(HomeController());
    // final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CheckMarkIndicator(
          onRefresh: () => controller.fetchJobs(isRefresh: true),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 22.h),
                  child: Row(
                    children: [
                      Obx(() {
                        final imagePath =
                            controller.jobSeekerProfile.value.profileImage;
                        log(imagePath.toString());

                        return CircleAvatar(
                          radius: 40.r,
                          backgroundImage: (imagePath ?? "").isEmpty
                              ? NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                                )
                              : NetworkImage(imagePath ?? ""),
                        );
                      }),

                      // CircleAvatar(
                      //   backgroundImage: AuthService.profileImage.isNotEmpty
                      //       ? NetworkImage(AuthService.profileImage)
                      //       : null,
                      // ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, ${controller.jobSeekerProfile.value.fullName}!",
                                style: getTextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconPath.location,
                                    width: 14.w,
                                    height: 14.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    controller.address.value,
                                    style: getTextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationScreen());
                        },
                        child: SvgPicture.asset(
                          IconPath.notification,
                          width: 44.w,
                          height: 44.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Search Bar
                CustomSearchBar(
                  controller: controller.searchQuery,
                  hintText: "Search...",
                  // onTap: () =>
                  //     Get.to(() => SearchScreen(homeController: controller)),
                  onFieldSubmitted: (_) {
                    controller.fetchJobs(isRefresh: false);
                  },
                  susfixIcon: Icons.filter_alt_outlined,
                  onclick: () {
                    log("Filter tab");
                    forJobSeekerBottomSheet(controller: controller);
                  },
                ),
                SizedBox(height: 24.h),

                // Categories Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: getTextStyle(
                            color: AppColors.black3,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        //   Text(
                        //     "See all",
                        //     style: getTextStyle(
                        //       color: AppColors.bluePrimary,
                        //       fontSize: 14.sp,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Row(
                          children: controller.categories
                              .map(
                                (item) => Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectCategory(item['value']!);
                                    },
                                    child: Obx(
                                      () => Opacity(
                                        opacity:
                                            controller.selectedCategory.value ==
                                                item['value']
                                            ? 1.0
                                            : 0.6,
                                        child: CustomCategoryTile(
                                          title: item['title']!,
                                          iconPath: item['icon']!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jobs Nearby",
                      style: getTextStyle(
                        color: AppColors.black3,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                    // Text(
                    //   "View All",
                    //   style: getTextStyle(
                    //     color: AppColors.blue3,
                    //     fontSize: 14.sp,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 18.h),

                Obx(() {
                  if (controller.isJobLoading.value &&
                      controller.jobs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }

                  if (controller.jobs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Text(
                          "No jobs found",
                          style: getTextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: controller.jobs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final job = controller.jobs[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: NearbyJobCard(
                              onChat: () {
                                Get.to(
                                  () => IndividualChatScreen(),
                                  arguments: {
                                    "isActive": job.isOnline.toString(),
                                    "lastActiveData": job.lastOnlineAt,
                                    "chatroomId": "",
                                    "isLiked": job.isLiked,
                                    "name": job.userName,
                                    "username": job.userName,
                                    "userId": job.userId,
                                    "image": job.profileImage,
                                  },
                                );
                              },
                              job: job,
                              onApply: () {
                                Get.to(
                                  () => JobDetailsScreen(),
                                  arguments: job,
                                );
                              },
                            ),
                          );
                        },
                      ),

                      if (controller.isPaginationLoading.value)
                        Padding(
                          padding: EdgeInsets.all(16.h),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
