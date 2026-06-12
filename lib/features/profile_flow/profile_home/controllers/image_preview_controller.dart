import 'package:get/get.dart';

class ImagePreviewController extends GetxController {
  final currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
