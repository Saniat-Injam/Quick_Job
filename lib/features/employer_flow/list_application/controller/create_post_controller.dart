import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/services/auth_service.dart';

import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

class CreateJobPostController extends GetxController {
  final namePositionController = TextEditingController();
  final seleryController = TextEditingController();
  final locationController = TextEditingController();
  final requirementsController = TextEditingController();
  final allRequerdMent = <String>[].obs;
  final typeRequardment = TextEditingController();

  RxBool isImageLoading = true.obs; // for profile loading
  RxBool isImageUploading = false.obs; // for image upload
  RxString jobVacancyImage = ''.obs; //

  // Job Type dropdowns
  var seletedType = ''.obs;
  final jobTypeList = ['ON_SITE', 'HYBRID', 'REMOTE'].obs;

  void seletedTroggleType(item) {
    seletedType.value = item;
    validateForm();
  }

  // Work Type
  var seletedWorkType = ''.obs;
  final workTypeList = ['Remote', 'Hybrid', 'On-Site'].obs;

  void seletedTroggleTypeWork(item) {
    seletedWorkType.value = item;
    validateForm();
  }

  // Job Category
  var seletedJobCategory = ''.obs;
  final jobCategoryList = [
    'CLEANING',
    'DRIVER_AND_DELIVERY',
    'KITCHEN_PORTER',
  ].obs;

  void seletedTroggleJobCategory(item) {
    seletedJobCategory.value = item;
    validateForm();
  }

  var isFormValid = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    namePositionController.addListener(validateForm);
    seleryController.addListener(validateForm);
    locationController.addListener(validateForm);
  }

  void addData() {
    if (typeRequardment.text.isNotEmpty) {
      allRequerdMent.add(typeRequardment.text.trim());
      typeRequardment.clear();
      Get.back();
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      isImageUploading.value = true; // start shimmer
      final response = await NetworkCaller().putMultipartRequest(
        url: AppUrls.createJobPost,
        filePath: image.path,
        fieldName: 'profileImage',
        method: 'PATCH',
      );

      if (response.isSuccess) {
        //await getMe();
        AppSnackBar.showSuccess("Profile image updated");
      } else {
        AppSnackBar.showError(response.errorMessage);
      }
    } catch (e) {
      AppSnackBar.showError("Image upload failed");
    } finally {
      isImageUploading.value = false; // stop shimmer
    }
  }

  void validateForm() {
    if (namePositionController.text.trim().isNotEmpty &&
        seleryController.text.trim().isNotEmpty &&
        locationController.text.trim().isNotEmpty &&
        seletedType.value.isNotEmpty &&
        seletedWorkType.value.isNotEmpty &&
        seletedJobCategory.value.isNotEmpty) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  String _mapJobType(String flutterJobType) {
    const jobTypeMap = {
      'Remote': 'REMOTE',
      'Hybrid': 'HYBRID',
      'On-Site': 'ON_SITE',
    };
    return jobTypeMap[flutterJobType] ?? 'ON_SITE';
  }

  // Future<void> createJobPost() async {
  //   try {
  //     // Validate that requirements are not empty
  //     if (allRequerdMent.isEmpty) {
  //       AppSnackBar.showError('Please add at least one requirement');
  //       return;
  //     }

  //     isLoading.value = true;

  //     final Map<String, dynamic> requestBody = {
  //       'jobPostStatus': 'ACTIVE',
  //       'position': namePositionController.text.trim(),
  //       'salary': int.tryParse(seleryController.text.trim()) ?? 0,
  //       'location': locationController.text.trim(),
  //       'requirements': allRequerdMent.toList(),
  //       'jobType': _mapJobType(seletedWorkType.value),
  //       'JobCategory': seletedJobCategory.value,
  //     };

  //     final response = await NetworkCaller().putMultipartRequest(
  //       AppUrls.createJobPost,
  //       body: requestBody,
  //       token: "Bearer ${AuthService.token}",
  //     );

  //     AppSnackBar.showSuccess('Create post successfully');
  //     clearForm();
  //     Get.close(2);
  //     // Get.offNamed('/home');
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to create job post: $e',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> createJobPost() async {
    try {
      // Validate that requirements are not empty
      if (allRequerdMent.isEmpty) {
        AppSnackBar.showError('Please add at least one requirement');
        return;
      }

      isLoading.value = true;

      final Map<String, dynamic> requestBody = {
        'jobPostStatus': 'ACTIVE',
        'position': namePositionController.text.trim(),
        'salary': int.tryParse(seleryController.text.trim()) ?? 0,
        'location': locationController.text.trim(),
        'requirements': allRequerdMent.toList(),
        'jobType': _mapJobType(seletedWorkType.value),
        'JobCategory': seletedJobCategory.value,
      };

      // Use the correct method for multipart
      final response = await NetworkCaller().postRequest(
        AppUrls.createJobPost,
        body: requestBody,
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {
        AppSnackBar.showSuccess('Create post successfully');
        clearForm();
        Get.close(2);
      } else {
        AppSnackBar.showError('Failed to create job post');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create job post: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    namePositionController.clear();
    seleryController.clear();
    locationController.clear();
    requirementsController.clear();
    typeRequardment.clear();
    allRequerdMent.clear();
    seletedType.value = '';
    seletedWorkType.value = '';
    seletedJobCategory.value = '';
    isFormValid.value = false;
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   namePositionController.dispose();
  //   seleryController.dispose();
  //   locationController.dispose();
  //   requirementsController.dispose();
  //   typeRequardment.dispose();
  // }
}
