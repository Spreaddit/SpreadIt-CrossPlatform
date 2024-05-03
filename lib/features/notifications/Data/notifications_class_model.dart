import 'package:equatable/equatable.dart';

class Notifications extends Equatable {
  final String? id;
  final String? content;
  final String notificationType;
  final RelatedUser? relatedUser;
  final bool isRead;
  final bool isHidden;
  final DateTime createdAt;
  final Comment? comment;
  final Post? post;
  final String? userId;
  final String? postId;
  final String? commentId;
  final String? communityname;
  final String? communitypic;

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
          ? json.containsKey('comment')
              ? Comment.fromJson(json['comment'])
              : null
          : null,
      post: json['post'] != null
          ? json.containsKey('post')
              ? Post.fromJson(json['post'])
              : null
          : Post(),
      userId: json['userId'] ?? "-1",
      postId: json['postId'] ?? "-1",
      commentId: json['commentId'] ?? "-1",
      communityname: json['name'] ?? '',
      communitypic: json['image'] ?? '',
    );
  }
}

class RelatedUser extends Equatable {
  final String? username;
  final String? avatarUrl;

  RelatedUser({
     this.username='',
     this.avatarUrl='',
  });

  @override
  List<Object?> get props => [username, avatarUrl];

  factory RelatedUser.fromJson(Map<String, dynamic> json) {
    return RelatedUser(
      username: json['username'] ?? '',
      avatarUrl: json['avatar'] ?? '',
    );
  }
}

class Post extends Equatable {
  final String title;
  final String community;

  Post({
     this.title='',
     this.community='',
  });

  @override
  List<Object?> get props => [title, community];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] ?? '',
      community: json['community'] ?? '',
    );
  }
}

class Comment extends Equatable {
  final String content;
  final String postTitle;
  final String communityTitle;

  Comment({
    required this.content,
    required this.postTitle,
    required this.communityTitle,
  });

  @override
  List<Object?> get props => [content, postTitle, communityTitle];

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      content: json['content'] ?? '',
      postTitle: json['postTitle'] ?? '',
      communityTitle: json['communityTitle'] ?? '',
    );
  }
}
