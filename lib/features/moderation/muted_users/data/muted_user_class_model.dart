import 'package:equatable/equatable.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';

/// Represents a user who has been muted in a community.
///
/// Each [MutedUser] object contains information about the muted user, including their profile picture, username,
/// the date when they were muted, and an optional note explaining the reason for muting.
class MutedUser extends Equatable {
  /// The URL of the user's profile picture.
  final String userProfilePic;

  /// The username of the muted user.
  final String username;

  /// The duration since the user was muted.
  final String date;

  /// An optional note explaining the reason for muting the user.
  String note;

  /// Creates a [MutedUser] object.
  ///
  /// The [userProfilePic], [username], and [date] parameters are required,
  /// while the [note] parameter is optional.
   MutedUser({
    required this.userProfilePic,
    required this.username,
    required this.date,
    this.note = '',
  });

  /// Creates a [MutedUser] object from JSON data.
  ///
  /// This factory constructor is used to create a [MutedUser] object from JSON data.
  /// The [json] parameter should contain keys 'avatar', 'username', 'muteDate', and 'muteReason'.
  factory MutedUser.fromJson(Map<String, dynamic> json) {
    return MutedUser(
      userProfilePic: json['avatar'],
      username: json['username'],
      date: dateToDuration(DateTime.parse(json['muteDate'])),
      note: json['muteReason'],
    );
  }

  @override
  List<Object> get props => [userProfilePic, username, date, note];
}
