
import '../../../user.dart';

class Comment {
  final String id;
  final String content;
  final User user;
  final int likesCount;  
  final int repliesCount; 
  final bool isReply;
  final List<String> media;
  final DateTime createdAt;
  final bool isHidden;
  final bool isSaved;
  final String postTitle;
  final String subredditName;

  Comment({
    required this.id,
    required this.content,
    required this.user,
    required this.likesCount,
    required this.repliesCount,
    required this.isReply,
    required this.media,
    required this.createdAt,
    required this.isHidden,
    required this.isSaved,
    required this.postTitle,
    required this.subredditName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      content: json['content'],
      user : User.fromJson(json['user']),
      likesCount: json['likes_count'],
      repliesCount: json['replies_count'],
      isReply: json['is_reply'],
      media: List<String>.from(json['media']),
      createdAt:DateTime.parse(json['created_at'] as String),
      isHidden: json['is_hidden'] as bool,
      isSaved: json['is_saved'] as bool,
      postTitle: json['post_title'],
      subredditName: json['community_title'],
    );
  }
}
