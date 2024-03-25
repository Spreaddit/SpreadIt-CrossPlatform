/// Post model for the post card
class Post {
  int postId;
  final String username;
  final String userId;
  final DateTime date;
  final String headline;
  final String? description;
  final String? imageUrl;
  final int votesCount;
  final int sharesCount;
  final int commentsCount;
  final String profilePic;

  Post({
    required this.postId,
    required this.username,
    required this.userId,
    required this.date,
    required this.headline,
    this.description,
    this.imageUrl,
    required this.votesCount,
    required this.sharesCount,
    required this.commentsCount,
    required this.profilePic,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        username: json["username"] as String,
        userId: json["userId"] as String,
        postId: json["postId"] as int,
        date: DateTime.parse(json["date"] as String),
        headline: json["headline"] as String,
        description: json["description"] as String,
        imageUrl: json["imageUrl"] as String,
        votesCount: json["votesCount"] as int,
        sharesCount: json["sharesCount"] as int,
        commentsCount: json["commentsCount"] as int,
        profilePic: json["profilePic"] as String,
      );
}
