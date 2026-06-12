import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<String?> makePayment() async {
    try {
      final result = await _createSetupIntent();
      if (result == null) return null;

      final clientSecret = result['client_secret']!;
      final setupIntentId = result['id']!;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: clientSecret,
          merchantDisplayName: "OliverDaimon",
          style: ThemeMode.light,
        ),
      );

      final success = await _processPayment();
      if (!success) return null;

      // Fetch setup intent details to retrieve payment_method ID
      final Dio dio = Dio();
      log("key id : ${dotenv.env['SECRET_KEY']}");
      final response = await dio.get(
        "https://api.stripe.com/v1/setup_intents/$setupIntentId",
        options: Options(
          headers: {"Authorization": "Bearer ${dotenv.env['SECRET_KEY']}"},
        ),
      );

      if (response.statusCode == 200) {
        final setupIntent = response.data;
        final paymentMethodId = setupIntent["payment_method"];
        log("Retrieved payment_method ID: $paymentMethodId");
        return paymentMethodId;
      } else {
        log("Failed to retrieve setup intent: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      log("StripeException: $error");
      return null;
    }
  }

  Future<Map<String, String>?> _createSetupIntent() async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {"payment_method_types[]": "card"};
      log("key id : ${dotenv.env['SECRET_KEY']}");
      final response = await dio.post(
        "https://api.stripe.com/v1/setup_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer ${dotenv.env['SECRET_KEY']}"},
        ),
      );

      if (response.data != null) {
        log('Setup Intent Response: ${response.data}');
        return {
          "client_secret": response.data["client_secret"],
          "id": response.data["id"],
        };
      }
      return null;
    } catch (e) {
      log('Error creating SetupIntent: $e');
      return null;
    }
  }

  Future<bool> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (error) {
      log("Payment failed: $error");
      return false;
    }
  }
}
