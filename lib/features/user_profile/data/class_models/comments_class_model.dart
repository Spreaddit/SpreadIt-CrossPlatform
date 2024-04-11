import 'package:spreadit_crossplatform/features/user.dart';

class Comment {
  final String id;
  final String content;
  final User? user;
  final int likesCount;
  final int? repliesCount;
  final bool? isReply;
  final List<String>? media;
  final DateTime createdAt;
  final bool? isHidden;
  final bool? isSaved;
  final String? postTitle;
  final String? subredditName;
  final List<Comment>? replies;
  int? commentParentId;
  bool isCollapsed;
  final String? profilePic;
  final String? userId;
  final String? postId;
  final String? username;

  Comment({
    required this.id,
    required this.content,
    this.user,
    required this.likesCount,
    this.repliesCount,
    this.isReply,
    this.media= const [],
    required this.createdAt,
    this.isHidden,
    this.isSaved,
    this.postTitle,
    this.subredditName,
    this.replies = const [],
    this.commentParentId = 1,
    this.postId = '1',
    this.userId='2',
    this.isCollapsed = false,
    this.profilePic = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    this.username="rehab",
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