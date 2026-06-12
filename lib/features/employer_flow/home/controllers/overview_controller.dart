import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/features/employer_flow/home/models/overview_model.dart';
import 'package:quick_job/core/services/auth_service.dart';

class OverviewController extends GetxController {
  final isLoading = true.obs;
  final overViewModel = Rxn<OverViewModel>();

  @override
  void onInit() {
    super.onInit();
    getOverviewData();
  }

  Future<void> getOverviewData() async {
    try {
      isLoading.value = true;

      final token = AuthService.token;

      log('DASHBOARD TOKEN: $token');

      final response = await http.get(
        Uri.parse(AppUrls.employerDashBoardData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('RAW RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        overViewModel.value = overViewModelFromJson(response.body);
      } else {
        log('Dashboard Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Dashboard Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
