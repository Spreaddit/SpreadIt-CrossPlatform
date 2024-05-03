import 'package:equatable/equatable.dart';

class FollowUser extends Equatable {
  final String username;
  final String avatar;
  final bool isFollowed;

  FollowUser({
    required this.username,
    required this.avatar,
    this.isFollowed = false,
  });

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
