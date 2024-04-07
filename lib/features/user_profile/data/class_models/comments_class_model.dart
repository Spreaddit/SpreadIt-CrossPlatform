class Comment {
  final String id;
  final String content;
  final int likesCount;  //MUST BE INT
  final int repliesCount; //MUST BE INT
  final bool isReply;
  final List<String> media;
  final DateTime createdAt;
  final String postTitle;
  final String subredditName;
  final String userName;

  Comment({
    required this.id,
    required this.content,
    required this.likesCount,
    required this.repliesCount,
    required this.isReply,
    required this.media,
    required this.createdAt,
    required this.postTitle,
    required this.subredditName,
    required this.userName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      likesCount: json['likes_count'],
      repliesCount: json['replies_count'],
      isReply: json['is_reply'],
      media: List<String>.from(json['media']),
      createdAt:DateTime.parse(json['created_at'] as String),
      postTitle: json['post_title'],
      subredditName: json['subreddit_name'],
      userName: json['user_name'],
    );
  }
}
