import 'package:equatable/equatable.dart';

/// Represents a notification object.
class Notifications extends Equatable {
  /// Unique identifier for the notification.
  final String? id;

  /// Content of the notification.
  final String? content;

  /// Type of the notification (e.g., comment, post, community).
  final String notificationType;

  /// Information about the user related to the notification.
  final RelatedUser? relatedUser;

  /// Indicates whether the notification has been read.
  final bool isRead;

  /// Indicates whether the notification is hidden.
  final bool isHidden;

  /// Timestamp indicating when the notification was created.
  final DateTime createdAt;

  /// Details of the related comment notification.
  final CommentNotification? comment;

  /// Details of the related post notification.
  final PostNotification? post;

  /// ID of the user associated with the notification.
  final String? userId;

  /// ID of the post associated with the notification.
  final String? postId;

  /// ID of the comment associated with the notification.
  final String? commentId;

  /// Name of the community associated with the notification.
  final String? communityname;

  /// Image URL of the community associated with the notification.
  final String? communitypic;

  /// Constructor for Notifications.
  Notifications({
    this.id,
    this.content,
    required this.notificationType,
    this.relatedUser,
    required this.isRead,
    required this.isHidden,
    required this.createdAt,
    this.comment,
    this.post,
    this.userId,
    this.postId,
    this.commentId,
    this.communityname,
    this.communitypic,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        notificationType,
        relatedUser,
        isRead,
        isHidden,
        createdAt,
        comment,
        post,
        userId,
        postId,
        commentId,
        communityname,
        communitypic,
      ];

  /// Factory method to create a Notifications object from a JSON map.
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id'] ?? 'id',
      content: json['content'] ?? 'content',
      notificationType: json['notification_type'] ?? 'community',
      relatedUser: json.containsKey('related_user')
          ? RelatedUser.fromJson(json['related_user'])
          : null,
      isRead: json['is_read'] ?? false,
      isHidden: json['is_hidden'] ?? false,
      createdAt:
          DateTime.parse(json['created_at'] ?? json['dateCreated'] ?? ''),
      comment: json['comment'] != null
          ? CommentNotification.fromJson(json['comment'])
          : CommentNotification(),
      post: json['post'] != null
          ? json.containsKey('post')
              ? PostNotification.fromJson(json['post'])
              : null
          : PostNotification(),
      userId: json['userId'] ?? "-1",
      postId: json['postId'] ?? "-1",
      commentId: json['commentId'] ?? "-1",
      communityname: json['name'] ?? '',
      communitypic: json['image'] ?? '',
    );
  }
}

/// Represents a related user in a notification.
class RelatedUser extends Equatable {
  /// Username of the related user.
  final String? username;

  /// URL of the avatar image of the related user.
  final String? avatarUrl;

  /// Constructor for RelatedUser.
  RelatedUser({
    this.username = '',
    this.avatarUrl = '',
  });

  @override
  List<Object?> get props => [username, avatarUrl];

  /// Factory method to create a RelatedUser object from a JSON map.
  factory RelatedUser.fromJson(Map<String, dynamic> json) {
    return RelatedUser(
      username: json['username'] ?? '',
      avatarUrl: json['avatar'] ?? '',
    );
  }
}

/// Represents details of a post notification.
class PostNotification extends Equatable {
  /// Title of the post.
  final String title;

  /// Name of the community to which the post belongs.
  final String community;

  /// Constructor for PostNotification.
  PostNotification({
    this.title = '',
    this.community = '',
  });

  @override
  List<Object?> get props => [title, community];

  /// Factory method to create a PostNotification object from a JSON map.
  factory PostNotification.fromJson(Map<String, dynamic> json) {
    return PostNotification(
      title: json['title'] ?? '',
      community: json['community'] ?? '',
    );
  }
}

/// Represents details of a comment notification.
class CommentNotification extends Equatable {
  /// Content of the comment.
  final String content;

  /// Title of the post to which the comment belongs.
  final String postTitle;

  /// Title of the community to which the post belongs.
  final String communityTitle;

  /// Constructor for CommentNotification.
  CommentNotification({
    this.content = '',
    this.postTitle = '',
    this.communityTitle = '',
  });

  @override
  List<Object?> get props => [content, postTitle, communityTitle];

  /// Factory method to create a CommentNotification object from a JSON map.
  factory CommentNotification.fromJson(Map<String, dynamic> json) {
    return CommentNotification(
      content: json['content'] ?? '',
      postTitle: json['postTitle'] ?? '',
      communityTitle: json['communityTitle'] ?? '',
    );
  }
}
