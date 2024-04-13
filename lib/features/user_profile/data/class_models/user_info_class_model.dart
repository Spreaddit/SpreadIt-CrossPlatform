/// This file defines the SocialMedia and UserInfo classes used to represent social media profiles and user information.

/// A class representing a social media platform.
class SocialMedia {
  /// The name of the platform.
  final String platform;
  /// The Title that will get rendered
  final String displayname; 
  /// The actual Url of the link
  final String url;

  /// Constructor for creating a SocialMedia object.
  SocialMedia({
    required this.platform,
    required this.displayname,
    required this.url,
  });

  /// Factory constructor for creating a SocialMedia object from JSON data.
  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      platform: json['platform'],
      displayname: json['displayName'],
      url: json['url'],
    );
  }
}

/// A class representing user information.
class UserInfo {
  /// The URL of the user's avatar.
  final String avatar;

  /// The username of the user.
  final String username;

  /// The display name of the user.
  final String displayname;

  /// A brief description about the user.
  final String about;

  /// The date when the user joined the platform.
  final String dateOfJoining;

  /// The URL of the user's background/banner image.
  final String background;

  /// The number of post karmas.
  final String postKarmaNo;

  /// The number of comment karmas.
  final String commentKarmaNo;

  /// The total number of karmas.
  final String numberOfKarmas;

  /// The follow status of the user.
  final bool followStatus;

  /// Indicates if the user's profile is visible.
  final bool isVisible;

  /// Indicates if the user is active.
  final bool isActive;

  /// List of social media profiles associated with the user.
  final List<SocialMedia> socialMedia;

  /// Constructor for creating a UserInfo object.
  UserInfo({
    required this.avatar,
    required this.username,
    required this.displayname,
    required this.about,
    required this.dateOfJoining,
    required this.background,
    this.postKarmaNo = "10",
    this.commentKarmaNo = "20",
    this.numberOfKarmas = "100",
    this.followStatus = false,
    required this.socialMedia,
    required this.isVisible,
    required this.isActive,
  });

  /// Factory constructor for creating a UserInfo object from JSON data.
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
