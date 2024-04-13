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
      displayname: json['displayName'],
      url: json['url'],
    );
  }
}

class UserInfo {
  final String avatar;
  final String username;
  final String displayname;
  final String about;
  final String dateOfJoining;
  final String background;
  final String postKarmaNo;
  final String commentKarmaNo;
  final String numberOfKarmas;
  final bool followStatus;
  final bool isVisible;
  final bool isActive;
  final List<SocialMedia> socialMedia;

  UserInfo({
    required this.avatar,
    required this.username,
    required this.displayname,
    required this.about,
    required this.dateOfJoining,
    required this.background,
    this.postKarmaNo="10",
    this.commentKarmaNo="20",
    this.numberOfKarmas="100",
    this.followStatus=false,         //                                          TO be updated later
    required this.socialMedia,
    required this.isVisible,
    required this.isActive,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) { 

    var socialMediaJson = json['socialLinks'] as List;
    List<SocialMedia> socialMedia = socialMediaJson
        .map((socialMediaJson) => SocialMedia.fromJson(socialMediaJson))
        .toList();

    return UserInfo(
      username: json['username'],
      displayname: json['name'],
      avatar: json['avatar'],
      background: json['banner'],
      about: json['about'],
      dateOfJoining: json['createdAt'], 
      isVisible: json['isVisible'],
      isActive: json['isActive'],
      socialMedia: socialMedia,
    );
}

}

