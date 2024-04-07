import 'package:spreadit_crossplatform/features/user_profile/data/class_models/community_class_model.dart';
class UserInfo {
  final String avatar;
  final String email;
  final String username;
  final String about;
  final String dateOfJoining;
  final String background;
  final String postKarmaNo;
  final String commentKarmaNo;
  final String numberOfKarmas;
  final bool followStatus;
  final List<Community> activeCommunities;

  UserInfo({
    required this.avatar,
    required this.email,
    required this.username,
    required this.about,
    required this.dateOfJoining,
    required this.background,
    required this.postKarmaNo,
    required this.commentKarmaNo,
    required this.numberOfKarmas,
    required this.followStatus,
    required this.activeCommunities,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    var activeCommunitiesJson = json['active_communities'] as List;
    List<Community> communities = activeCommunitiesJson
        .map((communityJson) => Community.fromJson(communityJson))
        .toList();

    return UserInfo(
      avatar: json['avatar'],
      email: json['email'],
      username: json['username'],
      about: json['about'],
      dateOfJoining: json['date_of_joining'],
      background: json['background'],
      postKarmaNo:json['number_of_post_karmas'],
      commentKarmaNo:json['number_of_comment_karmas'],
      numberOfKarmas: json['number_of_karmas'],
      followStatus: json['follow_status'],
      activeCommunities: communities,
    );
  }
}
