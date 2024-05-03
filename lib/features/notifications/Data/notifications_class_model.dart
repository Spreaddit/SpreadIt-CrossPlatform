import 'package:equatable/equatable.dart';

class Notifications extends Equatable {
  final String? id;
  final String? content;
  final String notificationType;
  final RelatedUser? relatedUser;
  final bool isRead;
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
      id: json['_id']??'id',
      content: json['content']??'content',
      notificationType: json['notificationType'] ?? 'community',
      relatedUser: json.containsKey('relatedUser')
          ? RelatedUser.fromJson(json['relatedUser'])
          : null,
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? json['dateCreated'] ??''),
      comment: json.containsKey('comment')
          ? Comment.fromJson(json['comment'])
          : null,
      post: json.containsKey('post') ? Post.fromJson(json['post']) : null,
      userId: json['userId'] ?? "-1",
      postId: json['postId'] ?? "-1",
      commentId: json['commentId'] ?? "-1",
      communityname: json['name'],
      communitypic: json['image'],
    );
  }
}

class RelatedUser extends Equatable {
  final String? username;
  final String? avatarUrl;

  RelatedUser({
    required this.username,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [username, avatarUrl];

  factory RelatedUser.fromJson(Map<String, dynamic> json) {
    return RelatedUser(
      username: json['username'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }
}

class Post extends Equatable {
  final String title;
  final String community;

  Post({
    required this.title,
    required this.community,
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
