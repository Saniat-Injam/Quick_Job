import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/profile_flow/help/views/widgets/faq_tile.dart';
import '../../controllers/faq_controller.dart';

class FaqScreen extends StatelessWidget {
  final FaqController faqController = Get.put(FaqController());
  FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h + kToolbarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: 20.h),
            CustomAppBar(title: 'Faq', backgroundColor: AppColors.transparent),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => ListView.builder(
            itemCount: faqController.faqList.length,
            itemBuilder: (context, index) {
              return FaqTile(
                faq: faqController.faqList[index],
                onTap: () => faqController.toggleExpansion(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
