class Community {
  final String profilePic;
  final String backgroundImage;
  final String name;
  final int members;

  Community({
    required this.profilePic,
    required this.backgroundImage,
    required this.name,
    required this.members,
  });

    factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      name: json['name'],
      backgroundImage: json['community_photo'],
      profilePic: json['class_photo'],
      members: json['number_of_members'],
    );
  }
}