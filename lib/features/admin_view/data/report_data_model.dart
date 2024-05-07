import 'package:equatable/equatable.dart';

/// `Report` is a data model that represents a report made by a user.
///
/// It extends the `Equatable` class to allow for value comparison.
///
/// It has three properties: `username`, `reason`, and `subreason`.
class Report extends Equatable {
  /// The username of the user who made the report.
  final String? username;

  /// The reason for the report.
  final String? reason;

  /// The subreason for the report.
  final String? subreason;

  /// Constructs a `Report` instance.
  ///
  /// All properties are required.
  Report({
    required this.username,
    required this.reason,
    required this.subreason,
  });

  /// Constructs a `Report` instance from a map.
  ///
  /// This factory constructor is used for deserializing a `Report` from JSON.
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      username: json['username'],
      reason: json['reason'],
      subreason: json['subreason'],
    );
  }

  /// Overrides the `props` getter from the `Equatable` class.
  ///
  /// Returns a list containing the properties of the `Report` instance.
  /// This is used by `Equatable` to determine equality.
  @override
  List<Object?> get props => [
        username,
        reason,
        subreason,
      ];
}
