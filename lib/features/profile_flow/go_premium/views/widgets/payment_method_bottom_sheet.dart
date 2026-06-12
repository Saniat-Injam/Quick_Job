import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/custom_button.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/services/payment_service.dart';
import 'package:quick_job/core/services/stripe_law_lavel_servies.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/features/profile_flow/go_premium/controllers/choose_plan_controller.dart';

class PaymentMethodSheet extends StatelessWidget {
  final String price; // dynamically received
  PaymentMethodSheet({super.key, required this.price});

  final ChoosePlanController controller = Get.find();
  final PaymentService paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    // Convert price string like "$9.99/mo" -> 9.99
    // double amount = double.parse(price.replaceAll(RegExp(r'[^0-9.]'), ''));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 48),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x143DC2DF),
            blurRadius: 12,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Payment Method',
                style: getTextStyle(
                  color: const Color(0xFF0E55FD),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Container(width: 327, height: 1, color: const Color(0xFFD1D6DB)),
            ],
          ),
          const SizedBox(height: 24),

          // Payment Option
          GestureDetector(
            onTap: () => controller.selectPayment("Stripe"),
            child: Container(
              width: 327,
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x26A7AEC1),
                    blurRadius: 80,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Container(
                    width: 86.23,
                    height: 41,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(LogoPath.stripe),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Radio Selection
                  Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: const Color(0xFF0E55FD),
                            ),
                          ),
                        ),
                        if (controller.selectedPayment.value == "Stripe")
                          Container(
                            width: 13,
                            height: 13,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0E55FD),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // CustomButton(
          //   text: 'Confirm and Pay',
          //   onPressed: () async {
          //     try {
          //       // Convert price string like "$9.99/mo" -> 9.99
          //       double amountDouble = double.parse(
          //         price.replaceAll(RegExp(r'[^0-9.]'), ''),
          //       );

          //       // Convert dollars to cents and make it integer
          //       int amountCents = (amountDouble * 100).toInt();

          //       // Call payment service
          //       await paymentService.makePayment(amountCents, 'usd');

          //       // Close bottom sheet
          //       Get.back();
          //     } catch (e) {
          //       print("Payment parsing error: $e");
          //     }
          //   },
          // ),
          CustomButton(
            text: 'Confirm and Pay',
            onPressed: () {
              log("hit this api");
              Get.back();
              Future.microtask(() async {
                await Future.delayed(const Duration(milliseconds: 200));
                if (Get.isDialogOpen == false) {
                  _startPayment(controller: controller);
                }
              });

              // try {
              //   double amountDouble = double.parse(
              //     price.replaceAll(RegExp(r'[^0-9.]'), ''),
              //   );

              //   int amountCents = (amountDouble * 100).toInt();

              //   // Call payment service
              //   await paymentService.makePayment(amountCents, 'usd');

              //   // Close ONLY AFTER a successful payment
              //   Get.back();
              // } catch (e) {
              //   print("Payment parsing error: $e");
              //   Get.snackbar(
              //     "Payment Error",
              //     e.toString(),
              //     backgroundColor: Colors.red,
              //     colorText: Colors.white,
              //   );
              // }
            },
          ),
        ],
      ),
    );
  }
}

void _startPayment({required ChoosePlanController controller}) async {
  final paymentMethodeID = await StripeService.instance.makePayment();

  log("---------------------------------------------------------------------");
  log("The payment method ID is: $paymentMethodeID");
  log("=====================================================================");
  log("=====================================================================");

  if (paymentMethodeID != null && paymentMethodeID.isNotEmpty) {
    controller.requestToPayment(paymentMethodId: paymentMethodeID);
  }
}
