class UserRoleModel {
  final String title;
  final String description;
  final String logoPath;
  final bool isPrimary;

  UserRoleModel({
    required this.title,
    required this.description,
    required this.logoPath,
    this.isPrimary = false,
  });
}
