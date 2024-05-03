import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String? username;
  final String? reason;
  final String? subreason;

  Report({
    required this.username,
    required this.reason,
    required this.subreason,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      username: json['username'],
      reason: json['reason'],
      subreason: json['subreason'],
    );
  }

  @override
  List<Object?> get props => [
        username,
        reason,
        subreason,
      ];
}
