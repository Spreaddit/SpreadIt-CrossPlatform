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
  String? cakeDay;
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
    this.cakeDay,
    this.subscribedCommunities,
    this.favouriteCommunities,
    this.socialLinks,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'googleId': googleId,
      'birth_date': birthDate?.toIso8601String(),
      'phone': phone,
      'avatar_url': avatarUrl,
      'background_picture_url': backgroundPictureUrl,
      'location': location,
      'bio': bio,
      'followers_count': followersCount,
      'following_count': followingCount,
      'created_at': createdAt?.toIso8601String(),
      'role': role,
      'nsfw': nsfw,
      'activeInCommunityVisibility': activeInCommunityVisibility,
      'isVerified': isVerified,
      'isVisible': isVisible,
      'isActive': isActive,
      'displayName': displayName,
      'about': about,
      'cakeDay': cakeDay,
      'subscribedCommunities': subscribedCommunities,
      'favouriteCommunities': favouriteCommunities,
      'socialLinks':
          socialLinks?.map((socialMedia) => socialMedia?.toJson()).toList(),
    };
  }

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
      followersCount: json['followers_count'] as int?,
      followingCount: json['following_count'] as int?,
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
      cakeDay: json['cakeDay'] as String?,
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
  final String? displayName; 
  final String? url;

  SocialMedia({
    this.platform,
    this.displayName,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'displayName': displayName, 
      'url': url,
    };
  }

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      platform: json['platform'],
      displayName: json['displayName'], 
      url: json['url'],
    );
  }
}
