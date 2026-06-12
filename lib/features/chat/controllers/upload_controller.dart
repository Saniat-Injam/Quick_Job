import 'package:get/get.dart';
import 'package:quick_job/features/chat/views/widgets/upload_dialog.dart';

class UploadController extends GetxController {
  void openGallery() {
    Get.back(); // Close dialog
    Get.snackbar('Gallery', 'Open Gallery clicked');
  }

  void openFile() {
    Get.back();
    Get.snackbar('File', 'Open File clicked');
  }

  void showUploadDialog() {
    Get.dialog(const UploadDialog());
  }
}
