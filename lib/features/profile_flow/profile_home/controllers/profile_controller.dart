import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_job/features/profile_flow/profile_home/models/profile_model.dart';
import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

class ProfileController extends GetxController {
  // 🔹 Reactive user profile variables
  var userName = 'Loading...'.obs;
  var email = 'Loading...'.obs;
  var role = 'UI/UX Designer'.obs;
  var profileImage = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
      .obs; // Local/Network image path
  RxBool isNotifyOn = true.obs;

  // 🔹 File picker variables
  final selectedFile = Rxn<PlatformFile>();
  final resumeId = RxString('');
  final isDeletingResume = RxBool(false);
  RxString imagePath = "".obs;
  final venueImage = ''.obs;

  RxBool isLoading = true.obs; // for profile loading
  RxBool isImageUploading = false.obs; // for image upload

  @override
  void onInit() {
    super.onInit();
    getMe(); // Fetch user profile when controller initializes
  }

  // Future<void> pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 80,
  //     );

  //     if (image == null) return;

  //     isImageUploading.value = true; // start shimmer
  //     final response = await NetworkCaller().uploadMultipart(
  //       url: AppUrls.employerProfileUpdate,
  //       filePath: image.path,
  //       fieldName: 'profileImage',
  //       method: 'PATCH',
  //     );

  //     if (response.isSuccess) {
  //       await getMe(); // refresh profile
  //       AppSnackBar.showSuccess("Profile image updated");
  //     } else {
  //       AppSnackBar.showError(response.errorMessage);
  //     }
  //   } catch (e) {
  //     AppSnackBar.showError("Image upload failed");
  //   } finally {
  //     isImageUploading.value = false; // stop shimmer
  //   }
  // }
  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      isImageUploading.value = true;

      final response = await NetworkCaller().putMultipartRequest(
        url: AppUrls.employerProfileUpdate,
        filePath: image.path,
        fieldName: 'profileImage',
        method: 'PATCH',
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {
        await getMe(); // refresh profile
        AppSnackBar.showSuccess("Profile image updated");
      } else {
        AppSnackBar.showError(response.errorMessage);
      }
    } catch (e) {
      AppSnackBar.showError("Image upload failed");
    } finally {
      isImageUploading.value = false;
    }
  }

  Future<void> getMe() async {
    try {
      isLoading.value = true; // start loading
      final response = await NetworkCaller().getRequest(
        AppUrls.getMe,
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {
        final resultData = response.responseData['result'];
        if (resultData != null) {
          final profile = UserProfileModel.fromJson(resultData);
          userName.value = profile.fullName;
          email.value = profile.email;
          profileImage.value = profile.profileImage.isNotEmpty
              ? profile.profileImage
              : "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
          AuthService.saveId(id: profile.id);
        }
      } else {
        AppSnackBar.showError("Failed to fetch profile");
      }
    } catch (e) {
      AppSnackBar.showError("Something went wrong");
    } finally {
      isLoading.value = false; // finish loading
    }
  }

  /// 🔹 Pick a file (resume)
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.isNotEmpty) {
        selectedFile.value = result.files.first;
      }
    } catch (e) {
      AppSnackBar.showError("Failed to pick file");
      log("pickFile error: $e");
    }
  }

  /// 🔹 Selected file name
  String get selectedFileName {
    return selectedFile.value?.name ?? 'No file selected';
  }

  /// 🔹 Selected file size
  String get selectedFileSize {
    return selectedFile.value?.size != null
        ? '${(selectedFile.value!.size / 1024).toStringAsFixed(2)} KB'
        : '0 KB';
  }

  /// 🔹 Delete selected file
  void deleteFile() {
    selectedFile.value = null;
    resumeId.value = '';
  }
}
