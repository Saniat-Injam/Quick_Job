class JobModel {
  final String title;
  final String company;
  final String location;
  final String type;
  final String salaryRange;
  final String logoPath;
  final List<String> requirements;

  JobModel({
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salaryRange,
    required this.logoPath,
    required this.requirements,
  });
}
