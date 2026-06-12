import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  // ----------------------------
  // 1. CREATE CUSTOMER
  // ----------------------------
  Future<String?> createCustomer() async {
    final url = Uri.parse('https://api.stripe.com/v1/customers');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['id'];
    } else {
      print("Customer Error: ${response.body}");
      Get.snackbar(
        "Payment Error",
        "Failed to create Stripe customer.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  // ----------------------------
  // 2. CREATE EPHEMERAL KEY
  // ----------------------------
  Future<String?> createEphemeralKey(String customerId) async {
    final url = Uri.parse('https://api.stripe.com/v1/ephemeral_keys');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['SECRET_KEY']}',
        'Stripe-Version': '2023-10-16',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'customer': customerId},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['secret'];
    } else {
      print("Ephemeral Key Error: ${response.body}");
      Get.snackbar(
        "Payment Error",
        "Failed to create ephemeral key.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  // ----------------------------
  // 3. CREATE PAYMENT INTENT
  // ----------------------------
  Future<String?> createPaymentIntent(
    int amount,
    String currency,
    String customerId,
  ) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': amount.toString(),
        'currency': currency,
        'customer': customerId,
        'automatic_payment_methods[enabled]': 'true',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['client_secret'];
    } else {
      print("Payment Intent Error: ${response.body}");
      Get.snackbar(
        "Payment Error",
        "Failed to create payment intent.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  // ----------------------------
  // 4. MAKE PAYMENT (MAIN FUNCTION)
  // ----------------------------
  Future<void> makePayment(int amount, String currency) async {
    try {
      // Step 1: Create Customer
      final customerId = await createCustomer();
      if (customerId == null) return;

      // Step 2: Create Ephemeral Key
      final eKey = await createEphemeralKey(customerId);
      if (eKey == null) return;

      // Step 3: Create Payment Intent
      final clientSecret = await createPaymentIntent(
        amount,
        currency,
        customerId,
      );
      if (clientSecret == null) return;

      // Step 4: Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Quick Job',
          customerId: customerId,
          customerEphemeralKeySecret: eKey,
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.light,
        ),
      );

      // Step 5: Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      print("PAYMENT SUCCESSFUL");
      Get.snackbar(
        "Success",
        "Payment completed successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('PAYMENT FAILED: $e');

      Get.snackbar(
        "Payment Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
