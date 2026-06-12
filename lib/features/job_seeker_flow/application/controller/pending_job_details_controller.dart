import 'package:get/get.dart';
import 'package:quick_job/features/job_seeker_flow/application/models/application_model.dart';

class PendingDetailsController extends GetxController {
  final Rx<ApplicationModel> application = ApplicationModel(
    title: "Financial Planner",
    company: "Twitter",
    salaryRange: "\$1.350K - \$2.350K",
    jobType: "Full Time",
    location: "United States",
    status: "Pending",
  ).obs;
}
