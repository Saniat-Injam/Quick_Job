import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/custom_submit_button.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';
import 'package:quick_job/features/profile_flow/go_premium/controllers/choose_plan_controller.dart';
import 'package:quick_job/features/profile_flow/go_premium/views/widgets/payment_method_bottom_sheet.dart';
import 'package:quick_job/features/profile_flow/go_premium/views/widgets/plan_card.dart';

class ChoosePlanScreen extends StatelessWidget {
  ChoosePlanScreen({super.key});

  final ChoosePlanController controller = Get.put(ChoosePlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                title: 'Choose Plan',
                backgroundColor: AppColors.transparent,
                padding: EdgeInsets.zero,
              ),
              Text(
                'Choose Your Plan',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Hire smarter, streamline staffing, and get the right match every time.',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: Obx(() {
                  if (controller.isSubLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    itemCount: controller.planList.length,
                    separatorBuilder: (_, _) => SizedBox(height: 24.h),
                    itemBuilder: (context, index) {
                      final plan = controller.planList[index];
                      return Obx(
                        () => PlanCard(
                          plan: plan,
                          onTap: () {
                            controller.changePlane(plan.id ?? "");
                          },
                          isSelectedColorForBg:
                              controller.selectedPlan.value == plan.id
                              ? Colors.blue.withValues(alpha: 0.1)
                              : Colors.white,
                          isSelectedColorForBorder:
                              controller.selectedPlan.value == plan.id
                              ? Colors.blue
                              : Colors.grey.shade400,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getHeight(16)),
          child: Obx(
            () => CustomSubmitButton(
              text: "Next",
              onTap: () {
                if (controller.selectedPlan.value.isNotEmpty) {
                  log("hit api");
                  Get.bottomSheet(
                    PaymentMethodSheet(price: "000"),
                    isScrollControlled: true,
                  );
                }
              },
              color: controller.selectedPlan.value.isEmpty
                  ? AppColors.grey4
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
