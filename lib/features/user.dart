class User {
  String id;
  String name;
  String username;
  String? email;
  String? googleId;
  DateTime? birthDate;
  String? phone;
  String? avatarUrl;
  String? backgroundPictureUrl;
  String? location;
  String? bio;
  int? followersCount;
  int? followingCount;
  DateTime? createdAt;
  String? role;
  bool? nsfw;
  bool? activeInCommunityVisibility;
  bool? isVerified;
  bool? isVisible;
  bool? isActive;
  String? displayName;
  String? about;
  bool? cakeDay;
  List<String?>? subscribedCommunities;
  List<String?>? favouriteCommunities;
  final List<SocialMedia?>? socialLinks;

  User({
    required this.id,
    required this.name,
    required this.username,
    this.email,
    this.googleId,
    this.birthDate,
    this.phone,
    this.avatarUrl,
    this.backgroundPictureUrl,
    this.location,
    this.bio,
    this.followersCount,
    this.followingCount,
    this.createdAt,
    this.role,
    this.nsfw,
    this.activeInCommunityVisibility,
    this.isVerified,
    this.isActive,
    this.isVisible,
    this.displayName,
    this.about,
    this.subscribedCommunities,
    this.favouriteCommunities,
    this.cakeDay,
    this.socialLinks,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var socialMediaJson = json['socialLinks'] as List;
    List<SocialMedia> socialLinks = socialMediaJson
        .map((socialMediaJson) => SocialMedia.fromJson(socialMediaJson))
        .toList();
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      googleId: json['googleId'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      backgroundPictureUrl: json['background_picture_url'],
      location: json['location'],
      bio: json['bio'],
      followersCount: json['followers_count'] as int,
      followingCount: json['following_count'] as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      role: json['role'],
      nsfw: json['nsfw'],
      activeInCommunityVisibility: json['activeInCommunityVisibility'],
      isActive: json['isActive'],
      isVisible: json['isVisible'],
      isVerified: json['isVerified'],
      displayName: json['displayName'],
      about: json['about'],
      cakeDay: json['cakeDay'] as bool?,
      subscribedCommunities: json['subscribedCommunities'] != null
          ? List<String>.from(json['subscribedCommunities'])
          : [],
      favouriteCommunities: json['favouriteCommunities'] != null
          ? List<String>.from(json['favouriteCommunities'])
          : [],
      socialLinks: socialLinks,
    );
  }
}

class SocialMedia {
  final String? platform;
  final String? displayname;
  final String? url;

  SocialMedia({
    this.platform,
    this.displayname,
    this.url,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      platform: json['platform'],
      displayname: json['displayName'],
      url: json['url'],
    );
  }
}
