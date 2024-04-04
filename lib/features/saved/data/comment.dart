class Comment {
  final String postTitle;
  final String communityTitle;
  final String time;
  final int votes;
  final String content;
  final String? username;

  Comment({
    required this.postTitle,
    required this.communityTitle,
    required this.time,
    required this.votes,
    required this.content,
    this.username,
  });
}