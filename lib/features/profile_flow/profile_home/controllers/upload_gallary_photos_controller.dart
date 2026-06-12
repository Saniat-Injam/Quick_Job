import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/multipart_network_caller.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/employer_flow/home/controllers/employer_home_controller.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/controllers/home_controller.dart';

class UploadGalleryController extends GetxController {
  RxList<String?> imageList = List<String?>.filled(5, null).obs;
  final ImagePicker _picker = ImagePicker();
  final employerHomeController = Get.find<EmployerHomeController>();
  final jobSeekerHomeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    // Get argument list

    final List? argList = AuthService.role == "EMPLOYEER"
        ? employerHomeController.employerProfileData.value.gallaryImages ?? []
        : jobSeekerHomeController.jobSeekerProfile.value.gallaryImages ?? [];
    if (argList != null && argList.isNotEmpty) {
      for (int i = 0; i < argList.length && i < imageList.length; i++) {
        imageList[i] = argList[i].toString();
      }
    }
  }

  Future<void> pickImage(int index, String oldImagePath) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      // imageList[index] = pickedFile.path;
      addOrUpdate(
        newImgPath: pickedFile.path,
        oldImgUrl: oldImagePath,
        index: index,
      );
      log("new img path is : ${pickedFile.path}");
      log("old img path is : $oldImagePath");
    }
  }

  Future<void> addOrUpdate({
    required String? oldImgUrl,
    required int index,
    required String newImgPath,
  }) async {
    try {
      log("old img : $oldImgUrl");
      bool hasOldImage =
          oldImgUrl != null && oldImgUrl.isNotEmpty && oldImgUrl != "null";

      String appURL = hasOldImage
          ? AppUrls.updateGalleryImg(index)
          : AppUrls.addNewGalleryImg;

      AppLoggerHelper.debug("App url : $appURL");
      loadingProgressIndicator();
      final response = await MultipartNetworkCaller.multiFormApiCall(
        apiUrl: appURL,
        method: 'PATCH',
        // requestBody: hasOldImage
        //     ? {
        //         "urlsToReplace": [oldImgUrl],
        //       }
        //     : {},
        galleryImagesPath: [newImgPath],
      );

      if (response) {
        AuthService.role == "EMPLOYEER"
            ? await employerHomeController.getUserProfile()
            : await jobSeekerHomeController.getUserProfile();
        final gallery = AuthService.role == "EMPLOYEER"
            ? employerHomeController.employerProfileData.value.gallaryImages ??
                  []
            : jobSeekerHomeController.jobSeekerProfile.value.gallaryImages ??
                  [];
        for (int i = 0; i < imageList.length; i++) {
          imageList[i] = i < gallery.length ? gallery[i] : null;
        }
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showSuccess(
          hasOldImage ? "Image update successful" : "Image added successful",
        );
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showError(
          hasOldImage ? "Error update Image" : "Error adding Image",
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError("Try again later!");
    }
  }

  // delete
  Future<void> deleteAImg({required int index}) async {
    try {
      loadingProgressIndicator();
      final response = await NetworkCaller().patchRequest(
        AppUrls.deleteImg(index),
        body: {},
      );

      if (response.isSuccess) {
        AuthService.role == "EMPLOYEER"
            ? await employerHomeController.getUserProfile()
            : await jobSeekerHomeController.getUserProfile();

        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        final gallery = AuthService.role == "EMPLOYEER"
            ? employerHomeController.employerProfileData.value.gallaryImages ??
                  []
            : jobSeekerHomeController.jobSeekerProfile.value.gallaryImages ??
                  [];
        for (int i = 0; i < imageList.length; i++) {
          imageList[i] = i < gallery.length ? gallery[i] : null;
        }
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showSuccess("Image delete successful");
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    }
  }
}
