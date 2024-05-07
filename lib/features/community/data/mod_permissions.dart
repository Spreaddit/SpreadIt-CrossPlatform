class ModPermissions {
  bool manageUsers;
  bool manageSettings;
  bool managePostsAndComments;

  ModPermissions({
    required this.manageUsers,
    required this.manageSettings,
    required this.managePostsAndComments,
  });

  factory ModPermissions.fromJson(Map<String, dynamic> json) {
    return ModPermissions(
      managePostsAndComments: json['managePostsAndComments'],
      manageUsers: json['manageUsers'],
      manageSettings: json['manageSettings'],
    );
  }
}
