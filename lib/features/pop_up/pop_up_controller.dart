import 'package:get/get.dart';
import 'package:quick_job/features/pop_up/success_popup_widget.dart';

class SuccessPopupController extends GetxController {
  var message = "".obs;
  var title = "".obs;

  void showPopup({required String titleText, required String messageText}) {
    title.value = titleText;
    message.value = messageText;
    Get.dialog(const SuccessPopupWidget(), barrierDismissible: false);
  }
}
