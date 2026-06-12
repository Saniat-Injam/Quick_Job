// import 'package:get/get.dart';

// class ApplyJobController extends GetxController {
//   final fullName = ''.obs;
//   final phoneNumber = ''.obs;
//   final email = ''.obs;
//   final isLoading = false.obs;

//   void onApply() async {
//     if (fullName.value.isEmpty ||
//         phoneNumber.value.isEmpty ||
//         email.value.isEmpty) {
//       Get.snackbar('Error', 'Please fill in all required fields');
//       return;
//     } else {
//       Get.snackbar('Success', 'Your application has been submitted!');
//     }
//   }

//   void uploadCV() {
//     Get.snackbar('Upload', 'CV upload coming soon!');
//   }
// }
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

class ApplyJobController extends GetxController {
  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final email = ''.obs;
  final isLoading = false.obs;
  final selectedFile = Rx<File?>(null);
  final errorMessage = ''.obs;
  final isFileUploaded = false.obs;
  var selectedFileName = ''.obs;
  var selectedFileSize = ''.obs;
  var selectedFileDate = ''.obs;
  var isFileSelected = false.obs;
  void selectFile(String name, String size, String date) {
    selectedFileName.value = name;
    selectedFileSize.value = size;
    selectedFileDate.value = date;
    isFileSelected.value = true;
  }

  Future<void> applyForJob(String jobPostId) async {
    try {
      if (jobPostId.isEmpty) {
        AppSnackBar.showError("Job Post ID is required.");
        return;
      }
      // if (re.isEmpty) {
      //   AppSnackBar.showError("Job Post ID is required.");
      //   return;
      // }
      loadingProgressIndicator();

      final url = AppUrls.jobApply(jobPostId: jobPostId);

      log('Applying for job with URL: $url');
      log('Using Bearer token: ${AuthService.token}');

      final response = await NetworkCaller().postRequest(
        url,
        body: {},
        token: "Bearer ${AuthService.token}",
      );
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.responseData}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        AppSnackBar.showSuccess("Successfully applied for the job!");
      } else if (response.statusCode == 409) {
        AppSnackBar.showError("Already apply this job!");
      } else {
        log('Error applying for job: ${response.responseData}');
        AppSnackBar.showError("Try again later!");
      }
    } catch (e) {
      AppSnackBar.showError("An error occurred: $e");
      log("Error applying for job: $e");
    }
  }

  void removeFile() {
    selectedFileName.value = '';
    selectedFileSize.value = '';
    selectedFileDate.value = '';
    isFileSelected.value = false;
  }

  Future<void> uploadCV() async {
    errorMessage.value = '';
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final extension = file.path.split('.').last.toLowerCase();
      if (['pdf'].contains(extension)) {
        selectedFile.value = file;
        isFileUploaded.value = true;
        errorMessage.value = '';
        Get.snackbar('Success', 'CV uploaded successfully');
      } else {
        selectedFile.value = null;
        isFileUploaded.value = false;
        errorMessage.value = 'Only PDF or Word files are allowed';
      }
    } else {
      selectedFile.value = null;
      isFileUploaded.value = false;
    }
  }
}
