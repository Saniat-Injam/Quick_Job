import 'dart:developer';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quick_job/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../onboarding/views/screens/onboarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _goToOnboarding();
  }

  void _goToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthService.init();

    log("Has token: ${AuthService.hasToken()}");
    log("The role: ${AuthService.role}");

    if (AuthService.hasToken()) {
      log("The role: ${AuthService.role}");
      Get.offAllNamed(AppRoute.bottomNavbar);
    } else {
      // No token found: Navigate to onboarding
      log("No authentication token found. Navigating to Onboarding.");
      Get.offAll(
        () => OnboardingScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
