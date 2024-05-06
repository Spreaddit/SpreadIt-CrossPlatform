import 'package:equatable/equatable.dart';

/// A class representing a user that can be followed.
///
/// This class holds information about a user including their username, avatar, and whether they are currently being followed.
///
/// Example usage:
/// ```dart
/// FollowUser user = FollowUser(username: 'example_user', avatar: 'user_avatar.png', isFollowed: true);
/// ```
class FollowUser extends Equatable {
  /// The username of the user.
  final String username;

  /// The avatar of the user.
  final String avatar;

  /// Indicates whether the user is currently being followed or not.
  final bool isFollowed;

  /// Constructs a new instance of [FollowUser].
  ///
  /// The [username] and [avatar] parameters are required, while [isFollowed] is optional.
  FollowUser({
    required this.username,
    required this.avatar,
    this.isFollowed = false,
  });

  /// Factory method to create a [FollowUser] instance from JSON data.
  ///
  /// The JSON data should have 'username' and 'avatar' fields.
  factory FollowUser.fromJson(Map<String, dynamic> json) {
    return FollowUser(
      username: json['username'],
      avatar: json['avatar'],
      isFollowed: json['isFollowed'] ?? false,
    );
  }

  @override
  List<Object?> get props => [username, avatar, isFollowed];

}
