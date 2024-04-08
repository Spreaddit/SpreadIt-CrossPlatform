class User {
  String id;
  String name;
  String username;
  String email;
  String googleId;
  DateTime birthDate;
  String phone;
  String avatarUrl;
  String backgroundPictureUrl;
  String location;
  String bio;
  int followersCount;
  int followingCount;
  DateTime createdAt;
  String role;
  bool nsfw;
  bool activeInCommunityVisibility;
  bool isVerified;
  String displayName;
  String about;
  DateTime cakeDay;
  List<String> subscribedCommunities;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.googleId,
    required this.birthDate,
    required this.phone,
    required this.avatarUrl,
    required this.backgroundPictureUrl,
    required this.location,
    required this.bio,
    required this.followersCount,
    required this.followingCount,
    required this.createdAt,
    required this.role,
    required this.nsfw,
    required this.activeInCommunityVisibility,
    required this.isVerified,
    required this.displayName,
    required this.about,
    required this.subscribedCommunities,
    required this.cakeDay,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        googleId = json['googleId'],
        birthDate = DateTime.parse(json['birth_date']),
        phone = json['phone'],
        avatarUrl = json['avatar_url'],
        backgroundPictureUrl = json['background_picture_url'],
        location=json['location'],
        bio = json['bio'],
        followersCount = json['followers_count'] as int,
        followingCount = json['following_count'] as int,
        createdAt = DateTime.parse(json['created_at']),
        role= json['role'],
        nsfw = json['nsfw'] as bool,
        activeInCommunityVisibility =json['activeInCommunityVisibility'] as bool,
        isVerified= json['isVerified'] as bool,
        displayName=json['displayName'],        
        about = json['about'] as String,
        cakeDay = DateTime.parse(json['cakeDay']),
        subscribedCommunities = List<String>.from(json['subscribedCommunities']);

}
