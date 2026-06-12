import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/common/widgets/custom_textformfield.dart';
import 'package:quick_job/core/common/widgets/gobel_checkmark_indicator.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';
import 'package:quick_job/features/employer_flow/home/controllers/employer_home_controller.dart';
import 'package:quick_job/features/employer_flow/home/controllers/overview_controller.dart';
import 'package:quick_job/features/employer_flow/home/controllers/recently_applied_candidates_controller.dart';
import 'package:quick_job/features/employer_flow/home/views/screens/my_post_view_all_screen.dart';
import 'package:quick_job/features/employer_flow/home/views/screens/recently_applied_candidates_view_all_screen.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/for_employee_bottom_sheet_filer.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/overview_card_skeleton.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/recently_applied_candidates_card.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/overview_card_widget.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/post_card_widget.dart';
import 'package:quick_job/features/employer_flow/home/views/widgets/recently_applied_candidates_skeleton.dart';
import 'package:quick_job/features/employer_flow/list_application/controller/employer_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/employer_aplication_detail_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/edit_job_post_detail_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/see_resume_screen.dart';
import 'package:quick_job/features/employer_flow/list_application/views/widget/bottom_sheet_sction.dart';
import 'package:quick_job/features/notification/views/screens/notification_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../profile_flow/profile_home/controllers/profile_controller.dart';

class EmployerHomeScreen extends StatelessWidget {
  final String userRole;
  EmployerHomeScreen({super.key, required this.userRole});

  final ProfileController profileController = Get.find();
  final OverviewController overviewController = Get.put(OverviewController());
  final EmployerController employerController = Get.find();
  final EmployerHomeController homeController = Get.put(
    EmployerHomeController(),
  );
  final RecentlyAppliedCandidatesController
  recentlyAppliedCandidatesController = Get.put(
    RecentlyAppliedCandidatesController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h), // Adjust height if needed
        child: Obx(
          () => CustomAppBar(
            title: homeController.employerProfileData.value.fullName,
            backgroundColor: AppColors.transparent,
            leadingImagePath:
                homeController.employerProfileData.value.profileImage,
            trailingIconPath: IconPath.notification,
            onTrailingTap: () => Get.to(() => NotificationScreen()),
            isLoading: profileController.isLoading.value,
          ),
        ),
      ),
      body: SafeArea(
        child: CheckMarkIndicator(
          // onRefresh: employerController.refreshJobs,
          onRefresh: () async {
            await employerController.refreshJobs();
            await recentlyAppliedCandidatesController.refreshFunction();
          },

          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: recentlyAppliedCandidatesController.scrollController,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 0,
                  left: 20,
                  right: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: CustomTextFormField(
                    controller:
                        recentlyAppliedCandidatesController.searchController,
                    hintText: "Search...",
                    onFieldSubmitted: (_) => recentlyAppliedCandidatesController
                        .fetchRecentlyApplied(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        log("Filter click");
                        forEmployeBottomSheet(
                          controller: recentlyAppliedCandidatesController,
                        );
                      },
                      child: Icon(Icons.filter_alt_outlined, size: 24.sp),
                    ),
                  ),
                ),
              ),
              // ===== OVERVIEW =====
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Obx(() {
                    if (overviewController.isLoading.value) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 1.5,
                        ),
                        itemBuilder: (_, __) => const OverviewCardSkeleton(),
                      );
                    }

                    final result =
                        overviewController.overViewModel.value?.result;

                    return GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 1.5,
                      ),
                      children: [
                        OverviewCardWidget(
                          label: 'Live Jobs',
                          value: result?.totalJobPost?.toString() ?? '0',
                          percentage: result?.jobPostChange?.percentage,
                          trend: result?.jobPostChange?.trend,
                        ),
                        OverviewCardWidget(
                          label: 'Applications',
                          value: result?.totalJobApplied?.toString() ?? '0',
                          percentage: result?.jobAppliedChange?.percentage,
                          trend: result?.jobAppliedChange?.trend,
                        ),
                        OverviewCardWidget(
                          label: 'Total Views',
                          value: result?.jobViews?.toString() ?? '0',
                          percentage: result?.jobViewsChange?.percentage,
                          trend: result?.jobViewsChange?.trend,
                        ),
                        OverviewCardWidget(
                          label: 'Candidates',
                          value: result?.jobCandidate?.toString() ?? '0',
                          percentage: result?.jobCandidateChange?.percentage,
                          trend: result?.jobCandidateChange?.trend,
                        ),
                      ],
                    );
                  }),
                ),
              ),

              // ===== MY POSTS HEADER =====
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Live Jobs',
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => MyPostViewAllScreen());
                        },
                        child: Text(
                          'View All',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            color: AppColors.bluePrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== MY POSTS LIST =====
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: Obx(() {
                  if (employerController.isLoading.value) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Container(
                            height: 84.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        childCount: 3,
                      ),
                    );
                  }

                  final jobs = employerController.homeJobPreview;

                  if (jobs.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: CustomText(
                          text: 'No job posts found',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greySecondary,
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final job = jobs[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: InkWell(
                          onTap: () {
                            BottomSheetAction.show(
                              onEdit: () {
                                Get.back();
                                Get.to(
                                  () => EditJobPostDetailScreen(jobData: job),
                                );
                              },
                              onDetail: () {
                                Get.back();
                                Get.to(
                                  () => EmployerAplicationDetailScreen(
                                    status: job['status'] ?? 'N/A',
                                    position: job['position'] ?? 'N/A',
                                    company: job['companyName'] ?? 'N/A',
                                    location: job['location'] ?? 'N/A',
                                    salary: job['salary'] ?? 0,
                                    jobId: job['id'] ?? 'N/A',
                                    requirements: job['requirements'] ?? [],
                                  ),
                                );
                              },
                              onPause: () {
                                Get.back();
                              },
                              onDelete: () {
                                Get.back();
                                Future.microtask(() async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 200),
                                  );
                                  if (Get.isDialogOpen == false) {
                                    homeController.deleteJobPost(
                                      jobPostId: job['id'],
                                    );
                                  }
                                });
                              },
                            );
                          },
                          child: PostCardWidget(
                            title: job['position'],
                            company: job['companyName'],
                            location: job['location'],
                            status: job['status'],
                            salary: job['salary'].toString(),
                            image: job['logo'] ?? IconPath.jobIcon,
                          ),
                        ),
                      );
                    }, childCount: jobs.length),
                  );
                }),
              ),

              // ===== PAGINATION LOADER =====
              Obx(
                () => employerController.isPaginationLoading.value
                    ? const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : const SliverToBoxAdapter(),
              ),

              // ===== RECENTLY APPLIED HEADER =====
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recently Applied',
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            () =>
                                const RecentlyAppliedCandidatesViewAllScreen(),
                          );
                        },
                        child: Text(
                          'View All',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bluePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== RECENTLY APPLIED LIST =====
              Obx(() {
                final controller = recentlyAppliedCandidatesController;

                if (controller.isLoadingApplied.value &&
                    controller.recentApplied.isEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 8.h,
                        ),
                        child: const RecentlyAppliedSkeleton(),
                      ),
                      childCount: 3,
                    ),
                  );
                }

                if (controller.recentApplied.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: CustomText(
                          text: 'No recent applications',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greySecondary,
                        ),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final info = controller.recentApplied[index];
                    final applied = info.jobSeekersProfile?.user;
                    final appliedOcopation = info.jobSeekersProfile;
                    final fileUrlList = appliedOcopation?.resumeList ?? [];
                    final uRL = fileUrlList.isNotEmpty
                        ? fileUrlList.first.resumeUrl
                        : "";
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: RecentlyAppliedCandidatesCard(
                        name: applied?.fullName ?? "NA",
                        title: appliedOcopation?.occupation ?? "NA",
                        image:
                            applied?.profileImage ??
                            "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                        onSeeResume: () {
                          log("Url lancher");

                          Get.to(() => SeeResumeScreen(pdfUrl: uRL));

                          // openFileExternally(fileUrl: uRL ?? "");
                        },
                        onSeeDetails: () {
                          log("I am form home page");
                          Get.to(
                            () => EmployerAplicationDetailScreen(
                              jobId: info.jobPost?.id ?? "",
                            ),
                          );
                        },
                        onCallTap: () async {
                          // log("Phone call tap!");
                          // controller.makePhoneCall(
                          //   phoneNumber: applied?.phoneNumber ?? "251412",
                          // );
                          final callID = DateTime.now().millisecondsSinceEpoch
                              .toString();
                          print("Call tap!");
                          log(appliedOcopation?.userId ?? "");
                          log(applied?.fullName ?? "NA");
                          await ZegoUIKitPrebuiltCallInvitationService().send(
                            invitees: [
                              ZegoCallUser(
                                appliedOcopation?.userId ?? "",
                                applied?.fullName ?? "NA",
                              ),
                            ],
                            isVideoCall: false,
                            callID: callID,
                            notificationMessage: "Incoming call.....",
                            notificationTitle: "Audio call",
                            timeoutSeconds: 30,
                          );
                        },
                        onChatTap: () {
                          log("${applied?.likeReceive?.isNotEmpty ?? false}");
                          Get.to(
                            () => IndividualChatScreen(),
                            arguments: {
                              "isActive": applied?.isOnline.toString() ?? "1",
                              "lastActiveData":
                                  applied?.lastActivateAt ?? DateTime.now(),
                              "chatroomId": "",
                              "isLiked":
                                  applied?.likeReceive?.isNotEmpty ?? false,

                              "name": applied?.fullName ?? "NA",
                              "username": applied?.fullName ?? "NA",
                              "userId": appliedOcopation?.userId ?? "",
                              "image":
                                  applied?.profileImage ??
                                  "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                            },
                          );
                        },
                      ),
                    );
                  }, childCount: controller.recentApplied.length),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
