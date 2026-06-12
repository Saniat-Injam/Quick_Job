import 'dart:developer';

import 'package:get/get.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import 'package:quick_job/features/role/models/user_role_model.dart';
import 'package:quick_job/routes/app_routes.dart';
import 'package:quick_job/features/auth/controllers/sign_up_controller.dart';

class RoleSelectionController extends GetxController {
  var selectedRole = Rxn<UserRoleModel>();

  final roles = <UserRoleModel>[
    UserRoleModel(
      title: 'JOB_SEEKERS',
      description: 'Finding a job here has never been easier than before',
      logoPath: LogoPath.jobSeekers,
    ),
    UserRoleModel(
      title: 'EMPLOYEER',
      description: 'Lets recruit your great candidate faster here',
      logoPath: LogoPath.employer,
    ),
  ].obs;

  void onRoleSelected(UserRoleModel role) async {
    selectedRole.value = role;
    log("role is : ${selectedRole.value?.title}");
    await AuthService.saveRole(role: selectedRole.value?.title ?? "EMPLOYEER");
    log("role is auth servies: ${AuthService.role.toString()}");
  }

  void goToNextPage() {
    if (selectedRole.value != null) {
      final signUpController = Get.find<SignUpController>();
      signUpController.selectedRole.value = selectedRole.value!.title;

      if (selectedRole.value!.title == 'JOB_SEEKERS' ||
          selectedRole.value!.title == 'EMPLOYEER') {
        Get.toNamed(
          AppRoute.loginScreen,
          arguments: {'role': selectedRole.value!.title},
        );
      } else {
        Get.snackbar(
          "Role not supported",
          "Please select a valid role to continue.",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "No role selected",
        "Please select a role to continue.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
