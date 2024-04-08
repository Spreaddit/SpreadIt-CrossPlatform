import 'package:spreadit_crossplatform/features/user_profile/data/class_models/community_class_model.dart';

class SocialMedia {
  final String platform;
  final String displayname;
  final String url;

  SocialMedia({
    required this.platform,
    required this.displayname,
    required this.url,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      platform: json['platform'],
      displayname: json['displayname'],
      url: json['url'],
    );
  }
}

class UserInfo {
  final String avatar;
  final String email;
  final String username;
  final String displayname;
  final String about;
  final String dateOfJoining;
  final String background;
  final String postKarmaNo;
  final String commentKarmaNo;
  final String numberOfKarmas;
  final bool followStatus;
  final List<Community> activeCommunities;
  final List<SocialMedia> socialMedia;

  UserInfo({
    required this.avatar,
    required this.email,
    required this.username,
    required this.displayname,
    required this.about,
    required this.dateOfJoining,
    required this.background,
    required this.postKarmaNo,
    required this.commentKarmaNo,
    required this.numberOfKarmas,
    required this.followStatus,
    required this.activeCommunities,
    required this.socialMedia,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    var activeCommunitiesJson = json['active_communities'] as List;
    List<Community> communities = activeCommunitiesJson
        .map((communityJson) => Community.fromJson(communityJson))
        .toList();

    var socialMediaJson = json['social_media'] as List;
    List<SocialMedia> socialMedia = socialMediaJson
        .map((socialMediaJson) => SocialMedia.fromJson(socialMediaJson))
        .toList();

    return UserInfo(
      avatar: json['avatar'],
      email: json['email'],
      username: json['username'],
      displayname: json['displayname'],
      about: json['about'],
      dateOfJoining: json['date_of_joining'],
      background: json['background'],
      postKarmaNo: json['number_of_post_karmas'],
      commentKarmaNo: json['number_of_comment_karmas'],
      numberOfKarmas: json['number_of_karmas'],
      followStatus: json['follow_status'],
      activeCommunities: communities,
      socialMedia: socialMedia,
    );
  }
}
