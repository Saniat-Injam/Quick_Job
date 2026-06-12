// import 'package:get/get.dart';
// import 'package:quick_job/core/utils/constants/logo_path.dart';
// import '../models/job_model.dart';

// class SearchResultJobController extends GetxController {
//   var jobs = <Job>[].obs;
//   var totalResults = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchJobs();
//   }

//   void fetchJobs() {
//     // Simulate API call
//     var fetchedJobs = [
//       Job(
//         title: 'UI/UX Designer',
//         company: 'AirBNB',
//         location: 'United States',
//         type: 'Full Time',
//         salary: '\$2.350K',
//         logoUrl: LogoPath.airBnb,
//       ),
//       Job(
//         title: 'Financial Planner',
//         company: 'Twitter',
//         location: 'United Kingdom',
//         type: 'Part Time',
//         salary: '\$2.340K',
//         logoUrl: LogoPath.twitter,
//       ),
//       Job(
//         title: 'Data Engineer',
//         company: 'LinkedIn',
//         location: 'Singapore',
//         type: 'Full Time',
//         salary: '\$3.120K',
//         logoUrl: LogoPath.linkedIn,
//       ),
//       Job(
//         title: 'UI/UX Designer',
//         company: 'AirBNB',
//         location: 'United States',
//         type: 'Full Time',
//         salary: '\$2.350K',
//         logoUrl: LogoPath.airBnb,
//       ),
//       Job(
//         title: 'Financial Planner',
//         company: 'Twitter',
//         location: 'United Kingdom',
//         type: 'Part Time',
//         salary: '\$2.340K',
//         logoUrl: LogoPath.twitter,
//       ),
//       Job(
//         title: 'Data Engineer',
//         company: 'LinkedIn',
//         location: 'Singapore',
//         type: 'Full Time',
//         salary: '\$3.120K',
//         logoUrl: LogoPath.linkedIn,
//       ),
//       Job(
//         title: 'UI/UX Designer',
//         company: 'AirBNB',
//         location: 'United States',
//         type: 'Full Time',
//         salary: '\$2.350K',
//         logoUrl: LogoPath.airBnb,
//       ),
//       Job(
//         title: 'Financial Planner',
//         company: 'Twitter',
//         location: 'United Kingdom',
//         type: 'Part Time',
//         salary: '\$2.340K',
//         logoUrl: LogoPath.twitter,
//       ),
//       Job(
//         title: 'Data Engineer',
//         company: 'LinkedIn',
//         location: 'Singapore',
//         type: 'Full Time',
//         salary: '\$3.120K',
//         logoUrl: LogoPath.linkedIn,
//       ),
//       Job(
//         title: 'UI/UX Designer',
//         company: 'AirBNB',
//         location: 'United States',
//         type: 'Full Time',
//         salary: '\$2.350K',
//         logoUrl: LogoPath.airBnb,
//       ),
//       Job(
//         title: 'Financial Planner',
//         company: 'Twitter',
//         location: 'United Kingdom',
//         type: 'Part Time',
//         salary: '\$2.340K',
//         logoUrl: LogoPath.twitter,
//       ),
//       Job(
//         title: 'Data Engineer',
//         company: 'LinkedIn',
//         location: 'Singapore',
//         type: 'Full Time',
//         salary: '\$3.120K',
//         logoUrl: LogoPath.linkedIn,
//       ),
//       Job(
//         title: 'UI/UX Designer',
//         company: 'AirBNB',
//         location: 'United States',
//         type: 'Full Time',
//         salary: '\$2.350K',
//         logoUrl: LogoPath.airBnb,
//       ),
//       Job(
//         title: 'Financial Planner',
//         company: 'Twitter',
//         location: 'United Kingdom',
//         type: 'Part Time',
//         salary: '\$2.340K',
//         logoUrl: LogoPath.twitter,
//       ),
//       Job(
//         title: 'Data Engineer',
//         company: 'LinkedIn',
//         location: 'Singapore',
//         type: 'Full Time',
//         salary: '\$3.120K',
//         logoUrl: LogoPath.linkedIn,
//       ),
//     ];

//     jobs.assignAll(fetchedJobs);
//     totalResults.value = fetchedJobs.length;
//   }
// }

import 'package:get/get.dart';
import 'package:quick_job/core/utils/constants/logo_path.dart';
import '../models/job_model.dart';

class SearchResultJobController extends GetxController {
  var allJobs = <Job>[].obs;
  var filteredJobs = <Job>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void fetchJobs() {
    var fetchedJobs = [
      Job(
        title: 'UI/UX Designer',
        company: 'AirBNB',
        location: 'United States',
        type: 'Full Time',
        salary: '\$2.350K',
        logoUrl: LogoPath.airBnb,
      ),
      Job(
        title: 'Financial Planner',
        company: 'Twitter',
        location: 'United Kingdom',
        type: 'Part Time',
        salary: '\$2.340K',
        logoUrl: LogoPath.twitter,
      ),
      Job(
        title: 'Data Engineer',
        company: 'LinkedIn',
        location: 'Singapore',
        type: 'Full Time',
        salary: '\$3.120K',
        logoUrl: LogoPath.linkedIn,
      ),
      Job(
        title: 'UI/UX Designer',
        company: 'AirBNB',
        location: 'United States',
        type: 'Full Time',
        salary: '\$2.350K',
        logoUrl: LogoPath.airBnb,
      ),
      Job(
        title: 'Financial Planner',
        company: 'Twitter',
        location: 'United Kingdom',
        type: 'Part Time',
        salary: '\$2.340K',
        logoUrl: LogoPath.twitter,
      ),
      Job(
        title: 'Data Engineer',
        company: 'LinkedIn',
        location: 'Singapore',
        type: 'Full Time',
        salary: '\$3.120K',
        logoUrl: LogoPath.linkedIn,
      ),
      Job(
        title: 'UI/UX Designer',
        company: 'AirBNB',
        location: 'United States',
        type: 'Full Time',
        salary: '\$2.350K',
        logoUrl: LogoPath.airBnb,
      ),
      Job(
        title: 'Financial Planner',
        company: 'Twitter',
        location: 'United Kingdom',
        type: 'Part Time',
        salary: '\$2.340K',
        logoUrl: LogoPath.twitter,
      ),
      Job(
        title: 'Data Engineer',
        company: 'LinkedIn',
        location: 'Singapore',
        type: 'Full Time',
        salary: '\$3.120K',
        logoUrl: LogoPath.linkedIn,
      ),
      Job(
        title: 'UI/UX Designer',
        company: 'AirBNB',
        location: 'United States',
        type: 'Full Time',
        salary: '\$2.350K',
        logoUrl: LogoPath.airBnb,
      ),
      Job(
        title: 'Financial Planner',
        company: 'Twitter',
        location: 'United Kingdom',
        type: 'Part Time',
        salary: '\$2.340K',
        logoUrl: LogoPath.twitter,
      ),
      Job(
        title: 'Data Engineer',
        company: 'LinkedIn',
        location: 'Singapore',
        type: 'Full Time',
        salary: '\$3.120K',
        logoUrl: LogoPath.linkedIn,
      ),
    ];

    allJobs.assignAll(fetchedJobs);
    filteredJobs.assignAll(fetchedJobs);
  }

  void searchJob(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredJobs.assignAll(allJobs);
    } else {
      final results = allJobs.where(
        (job) =>
            job.title.toLowerCase().contains(query.toLowerCase()) ||
            job.company.toLowerCase().contains(query.toLowerCase()),
      );
      filteredJobs.assignAll(results);
    }
  }
}
