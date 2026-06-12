import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';
import 'package:quick_job/features/splash_screen/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // App Logo
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagePath.quickJob, width: 295.49, height: 242),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    children: [
                      // TextSpan(
                      //   text: 'Quick ',
                      //   style: TextStyle(
                      //     fontSize: 36,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // TextSpan(
                      //   text: 'Job',
                      //   style: TextStyle(
                      //     fontSize: 36,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color(0xFF0057FF),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Loader animation
            const SpinKitCircle(color: Color(0xFF0057FF), size: 50),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
