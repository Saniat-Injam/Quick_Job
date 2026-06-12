import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/routes/app_routes.dart';
import '../../../../core/common/widgets/app_snack_bar.dart';

class ResumeController extends GetxController {
  final selectedFile = Rxn<PlatformFile>();
  final resumeId = RxString('');
  final isDeletingResume = RxBool(false);

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      selectedFile.value = result.files.first;
    }
  }

  String get selectedFileName {
    return selectedFile.value?.name ?? 'No file selected';
  }

  String get selectedFileSize {
    return selectedFile.value?.size != null
        ? '${(selectedFile.value!.size / 1024).toStringAsFixed(2)} KB'
        : '0 KB';
  }
  void deleteFile() {
    selectedFile.value = null;
    resumeId.value = '';
  }
  Future<void> resumeUpload() async {
    try {
      if (selectedFile.value == null) {
        AppSnackBar.showError("No file selected. Please select a resume.");
        return;
      }

      await loadingProgressIndicator(title: "Uploading.....");
      String? token = await _getAuthToken();

      if (token == null || token.isEmpty) {
        Get.back();
        AppSnackBar.showError("Authentication required. Please login again.");
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppUrls.uploadResume),
      );
      request.headers['Authorization'] = 'Bearer $token';
      String filePath = selectedFile.value!.path!;
      String fileName = selectedFile.value!.name;
      final mimeType = lookupMimeType(filePath) ?? "application/octet-stream";
      final splitMime = mimeType.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          "resumeFile",
          filePath,
          filename: fileName,
          contentType: MediaType(splitMime[0], splitMime[1]),
        ),
      );

      log("Uploading file: $fileName with mime type: $mimeType");

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      log("Response status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        final jsonResponse = jsonDecode(responseData);

        AppSnackBar.showSuccess(
            jsonResponse['message'] ?? "Resume uploaded successfully."
        );
        Get.toNamed(AppRoute.bottomNavbar);
        log("File uploaded successfully");
      } else {
        Get.back();
        AppSnackBar.showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.back();
      AppSnackBar.showError("Error: $e");
      log("Exception during file upload: $e");
    }
  }

  // Future<void> deleteResume(String resumeId) async {
  //
  //   try {
  //     isDeletingResume.value = true;
  //     await loadingProgressIndicator("Deleting resume.....");
  //
  //     String? token = await _getAuthToken();
  //
  //     if (token == null || token.isEmpty) {
  //       Get.back();
  //       AppSnackBar.showError("Authentication required. Please login again.");
  //       return;
  //     }
  //
  //     final url = Uri.parse(AppUrls.deleteResume(resumeId: resumeId)).replace(
  //       queryParameters: {'resumeId': resumeId},
  //     );
  //
  //     var request = http.MultipartRequest('DELETE', url);
  //     request.headers['Authorization'] = 'Bearer $token';
  //
  //     if (selectedFile.value != null) {
  //       String filePath = selectedFile.value!.path!;
  //       String fileName = selectedFile.value!.name;
  //       final mimeType = lookupMimeType(filePath) ?? "application/octet-stream";
  //       final splitMime = mimeType.split('/');
  //
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           "resumeFile",
  //           filePath,
  //           filename: fileName,
  //           contentType: MediaType(splitMime[0], splitMime[1]),
  //         ),
  //       );
  //     }
  //
  //     final response = await request.send();
  //     final responseData = await response.stream.bytesToString();
  //
  //     Get.back();
  //
  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       this.resumeId.value = '';
  //       selectedFile.value = null;
  //
  //       AppSnackBar.showSuccess("Resume deleted successfully.");
  //       log("Resume deleted successfully with ID: $resumeId");
  //     } else {
  //       AppSnackBar.showError("Failed to delete resume");
  //     }
  //   } catch (error) {
  //     Get.back();
  //     log("Exception during resume deletion: $error");
  //     AppSnackBar.showError("An error occurred");
  //   } finally {
  //     isDeletingResume.value = false;
  //   }
  // }

  Future<String?> _getAuthToken() async {
    return AuthService.token;
  }
}