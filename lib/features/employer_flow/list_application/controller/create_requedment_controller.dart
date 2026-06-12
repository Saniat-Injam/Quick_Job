import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../views/widget/custom_popup_screen.dart';

class CreateRequedmentController extends GetxController {
  final allRequerdMent = [].obs;
  final typeRequardment = TextEditingController();

  void addData() {
    if (typeRequardment.text.isNotEmpty) {
      allRequerdMent.add(typeRequardment.text);
      typeRequardment.clear();
      Get.back();
    } else {
      print("Else tap");
    }
    print("Globel tap!");
  }

  var seletedWorkType = ''.obs;

  final workTypeList = ['Remote', 'Hybrid', 'On-Site'].obs;
  final namePositionController = TextEditingController();
  final seleryController = TextEditingController();
  final locationController = TextEditingController();
  final requirementsController = TextEditingController();
  String _mapJobType(String flutterJobType) {
    const jobTypeMap = {
      'Remote': 'REMOTE',
      'Hybrid': 'HYBRID',
      'On-Site': 'ON_SITE',
    };
    return jobTypeMap[flutterJobType] ?? 'ON_SITE';
  }

  var seletedJobCategory = ''.obs;

  final jobCategoryList = [
    'CLEANING',
    'DRIVER_AND_DELIVERY',
    'KITCHEN_PORTER',
  ].obs;

  void seletedTroggleJobCategory(item) {
    seletedJobCategory.value = item;
  }

  var isFormValid = false.obs;
  var isLoading = false.obs;
  Future<void> createJobPost() async {
    try {
      // Validate all required fields
      if (namePositionController.text.trim().isEmpty) {
        AppSnackBar.showError('Please enter position name');
        return;
      }
      if (seleryController.text.trim().isEmpty) {
        AppSnackBar.showError('Please enter salary');
        return;
      }
      if (locationController.text.trim().isEmpty) {
        AppSnackBar.showError('Please enter location');
        return;
      }
      if (seletedWorkType.value.isEmpty) {
        AppSnackBar.showError('Please select work type');
        return;
      }
      if (seletedJobCategory.value.isEmpty) {
        AppSnackBar.showError('Please select job category');
        return;
      }
      if (allRequerdMent.isEmpty) {
        AppSnackBar.showError('Please add at least one requirement');
        return;
      }

      isLoading.value = true;

      // Get and validate token
      String? token = AuthService.token;
      if (token == null || token.isEmpty) {
        Get.to(() => CustomPopupScreen(isConfirm: false));
        return;
      }

      final Map<String, dynamic> requestBody = {
        'jobPostStatus': 'ACTIVE',
        'position': namePositionController.text.trim(),
        'salary': int.tryParse(seleryController.text.trim()) ?? 0,
        'location': locationController.text.trim(),
        'requirements': allRequerdMent.toList(),
        'jobType': _mapJobType(seletedWorkType.value),
        'jobCategory': seletedJobCategory.value,
      };

      print('=== Job Post Request ===');
      print('Token: Bearer $token');
      print('Request Body: $requestBody');

      final response = await NetworkCaller().postRequest(
        AppUrls.createJobPost,
        body: requestBody,
        token: "Bearer $token",
      );

      if (response.statusCode == 201) {
        clearForm();
        Get.to(() => CustomPopupScreen(isConfirm: true));
      } else {
        Get.to(() => CustomPopupScreen(isConfirm: false));
      }
    } catch (e) {
      print('Error creating job post: $e');
      Get.off(() => CustomPopupScreen(isConfirm: false));
    } finally {
      isLoading.value = false;
    }
  }

  // for type dropdown
  var seletedType = ''.obs;

  final jobTypeList = [
    'Full-Time',
    'Part-Time',
    'Contract / Temporary',
    'Internship',
    'Freelance / Gig',
    'Seasonal',
  ].obs;

  void seletedTroggleType(item) {
    seletedType.value = item;
  }

  // List<String> _parseRequirements(String requirementsText) {
  //   if (requirementsText.isEmpty) return [];
  //   return requirementsText
  //       .split(RegExp(r'[,\n]'))
  //       .map((req) => req.trim())
  //       .where((req) => req.isNotEmpty)
  //       .toList();
  // }

  void clearForm() {
    namePositionController.clear();
    seleryController.clear();
    locationController.clear();
    requirementsController.clear();
    seletedType.value = '';
    seletedWorkType.value = '';
    seletedJobCategory.value = '';
    isFormValid.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    typeRequardment.dispose();
  }
}
