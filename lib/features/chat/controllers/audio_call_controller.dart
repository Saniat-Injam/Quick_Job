import 'package:get/get.dart';

class ProfileAlertController extends GetxController {
  // Example data
  final name = 'Cameron Williamson'.obs;
  final phone = '(+44) 50 9285 3022'.obs;
  final imageUrl = 'https://placehold.co/140x140'.obs;

  void onCallPressed() {
    // Add call functionality
    print("Call button pressed");
  }

  void onEndCallPressed() {
    // Add end call functionality
    print("End call button pressed");
  }
}
