/// This file defines the Comment class, which represents a comment in a Flutter application.
/// It includes properties and methods related to comments.

import 'package:spreadit_crossplatform/features/user.dart';

/// A class representing a comment.
class Comment {
  /// Unique identifier for the comment.
  final String id;
  /// The text content of the comment.
  String content;
  /// The user who made the comment.
  final User? user;
  /// Number of likes the comment has received.
  final int likesCount;
  /// Number of replies the comment has received.
  final int? repliesCount;
  /// Indicates if the comment is a reply to another comment.
  final bool? isReply;
  /// List of media (such as images) associated with the comment.
  final List<String>? media;
  /// Date and time when the comment was created.
  final DateTime createdAt;
  /// Indicates if the comment is hidden from view.
  final bool? isHidden;
  /// Indicates if the comment is saved by the user.
  final bool? isSaved;
  /// Title of the post to which the comment belongs.
  final String? postTitle;
  /// Name of the subreddit (community) where the comment was posted.
  final String? subredditName;
  /// List of replies to the comment.
  List<Comment>? replies;
  /// ID of the parent comment if this comment is a reply.
  int? commentParentId;
  /// Indicates if the comment is collapsed (hidden from view) by the user.
  bool isCollapsed;
  /// URL of the profile picture of the user who made the comment.
  final String? profilePic;
  /// ID of the user who made the comment.
  final String? userId;
    /// ID of the post to which the comment belongs.
  final String? postId;
  final String? username;
  /// Constructor for creating a Comment object.
  Comment({
    required this.id,
    required this.content,
    this.user,
    required this.likesCount,
    this.repliesCount,
    this.isReply,
    this.media = const [],
    required this.createdAt,
    this.isHidden,
    this.isSaved,
    this.postTitle,
    this.subredditName,
    this.replies = const [],
    this.commentParentId = 1,
    this.postId = '1',
    this.userId = '2',
    this.isCollapsed = false,
    this.profilePic = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    this.username = "rehab",
  });

  /// Factory constructor for creating a Comment object from JSON data.
  factory Comment.fromJson(Map<String, dynamic> json) {
    // Extracting the username from the user data.
    String usernameFetched = User.fromJson(json['user']).username;
    // Creating a Comment object from JSON data.
    return Comment(
      id: json['id'],
      content: json['content'],
      user: User.fromJson(json['user']),
      likesCount: json['likes_count'],
      repliesCount: json['replies_count'],
      isReply: json['is_reply'],
      media: List<String>.from(json['media']),
      createdAt: DateTime.parse(json['created_at'] as String),
      isHidden: json['is_hidden'] as bool,
      isSaved: json['is_saved'] as bool,
      postTitle: json['post_title'],
      subredditName: json['community_title'],
      username: usernameFetched,
    );
  }
}
