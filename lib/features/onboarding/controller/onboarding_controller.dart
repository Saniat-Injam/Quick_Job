import 'package:get/get.dart';
import 'package:quick_job/features/role/views/screens/role_selection_screen.dart';

class OnboardingController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void goToNextPage() {
    Get.to(() => RoleSelectionScreen());
  }
}
