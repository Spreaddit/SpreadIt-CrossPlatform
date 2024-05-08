import 'package:equatable/equatable.dart';

class ModPermissions extends Equatable {
  final bool manageUsers;
  final bool manageSettings;
  final bool managePostsAndComments;

  ModPermissions({
    required this.manageUsers,
    required this.manageSettings,
    required this.managePostsAndComments,
  });

  factory ModPermissions.fromJson(Map<String, dynamic> json) {
    return ModPermissions(
      managePostsAndComments: json['managePostsAndComments'] ?? false,
      manageUsers: json['manageUsers'] ?? false,
      manageSettings: json['manageSettings'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        manageUsers,
        manageSettings,
        managePostsAndComments,
      ];

  @override
  bool? get stringify =>
      true; // If you want to include field names in toString()

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModPermissions &&
          other.manageUsers == manageUsers &&
          other.manageSettings == manageSettings &&
          other.managePostsAndComments == managePostsAndComments;

  @override
  int get hashCode =>
      manageUsers.hashCode ^
      manageSettings.hashCode ^
      managePostsAndComments.hashCode;
}
