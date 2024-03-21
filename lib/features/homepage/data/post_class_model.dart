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
}
