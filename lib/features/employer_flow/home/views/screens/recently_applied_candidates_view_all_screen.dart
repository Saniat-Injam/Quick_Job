import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/helpers/app_helper.dart';
import 'package:quick_job/features/chat/views/screens/individual_chat_screen.dart';
import 'package:quick_job/features/employer_flow/home/controllers/recently_applied_candidates_controller.dart';
import 'package:quick_job/features/employer_flow/list_application/views/screens/employer_aplication_detail_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../widgets/recently_applied_candidates_card.dart';

class RecentlyAppliedCandidatesViewAllScreen extends StatelessWidget {
  const RecentlyAppliedCandidatesViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecentlyAppliedCandidatesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Applied'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingApplied.value &&
            controller.recentApplied.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.recentApplied.isEmpty) {
          return const Center(child: Text('No candidates found'));
        }
        log("length is : ${controller.recentApplied.length}");
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller.scrollController,
          padding: EdgeInsets.all(8.h),
          itemCount: controller.recentApplied.length,
          itemBuilder: (context, index) {
            final info = controller.recentApplied[index];
            final applied = info.jobSeekersProfile?.user;
            final appliedOcopation = info.jobSeekersProfile;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RecentlyAppliedCandidatesCard(
                name: applied?.fullName ?? "NA",
                title: appliedOcopation?.occupation ?? "NA",
                image:
                    applied?.profileImage ??
                    "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",

                onSeeResume: () {
                  // Get.to(() => SeeResumeScreen());
                  log("Url lancher");
                  final fileUrlList = appliedOcopation?.resumeList ?? [];
                  final uRL = fileUrlList.isNotEmpty
                      ? fileUrlList.first.resumeUrl
                      : "";
                  openFileExternally(fileUrl: uRL ?? "");
                },
                onSeeDetails: () {
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
                    timeoutSeconds: 60,
                  );
                },
                onChatTap: () {
                  Get.to(
                    () => IndividualChatScreen(),
                    arguments: {
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
          },
        );
      }),
    );
  }
}
