import 'dart:developer';

import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/profile_flow/go_premium/models/plan_model.dart';

class ChoosePlanController extends GetxController {
  final selectedPlan = ''.obs;
  final selectedPayment = 'Stripe'.obs;

  // void selectPlan(Plan plan) {
  //   selectedPlan.value = plan.title;
  //   selectedPlanObject.value = plan;
  //   showPaymentSheet(plan.price); // pass price dynamically
  // }

  void selectPayment(String payment) {
    selectedPayment.value = payment;
  }

  void changePlane(String id) {
    if (selectedPlan.value == id) {
      selectedPlan.value = "";
    } else {
      selectedPlan.value = id;
    }
    log(selectedPlan.value);
  }

  // void showPaymentSheet(String price) {
  //   Get.bottomSheet(PaymentMethodSheet(price: price), isScrollControlled: true);
  // }

  @override
  void onInit() {
    super.onInit();
    getAllSubscriptionPlan();
  }

  final isSubLoading = false.obs;
  final planList = <AllPlan>[].obs;

  // get all subscription plan
  Future<void> getAllSubscriptionPlan() async {
    try {
      isSubLoading(true);
      final response = await NetworkCaller().getRequest(
        AppUrls.getAllSubscriptionPlan,
      );
      if (response.isSuccess) {
        log("Plan fetch");
        final data = GetAllSubscriptionPlan.fromJson(response.responseData);
        planList.value = data.result ?? [];
      } else {
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    } finally {
      isSubLoading(false);
    }
  }

  final isPaymentLoading = false.obs;
  // when payment is done
  Future<void> requestToPayment({required String paymentMethodId}) async {
    try {
      isPaymentLoading(true);
      final body = {
        "subscriptionId": selectedPlan.value,
        "paymentMethodId": paymentMethodId,
      };
      final response = await NetworkCaller().postRequest(
        AppUrls.buySubscriptionPlan,
        body: body,
      );
      if (response.isSuccess) {
        log("successful");
        Get.back();
        AppSnackBar.showSuccess("Payment successful!");
      } else {
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    } finally {
      isPaymentLoading(false);
    }
  }
}
