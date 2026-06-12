import 'package:get/get.dart';
import 'package:quick_job/features/job_seeker_flow/job_seeker_home/models/nearby_job_model.dart';

class JobDetailsController extends GetxController {
  var job = Rx<NearbyJobModel>(
    NearbyJobModel(
      profileImage: '',
      title: '',
      company: '',
      salary: '',
      location: '',
      postedTime: '',
      jobType: '',
      jobCategory: '',
      requirements: [],
      jobPostStatus: '',
      isLiked: false,
      id: '',
      userId: "",
      userName: '',
      isOnline: 1,
      lastOnlineAt: DateTime.now(),
    ),
  );
  var jobPostId = ''.obs;
  void setJobDetails(NearbyJobModel fetchedJob) {
    job.value = fetchedJob;
    jobPostId.value = fetchedJob.id;
  }
}
