class Notifications {
  final String id;
  final String content;
  final String notificationType;
  final RelatedUser relatedUser;
  final bool isRead;
  final DateTime createdAt;
  final Comment? comment;
  final Post? post;
  final String userId; 
  final String postId; 
  final String commentId; 

  Notifications({
    required this.id,
    required this.content,
    required this.notificationType,
    required this.relatedUser,
    required this.isRead,
    required this.createdAt,
    this.comment,
    this.post,
    required this.userId,
    required this.postId,
    required this.commentId,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id'] ?? "-1",
      content: json['content'] ??"-1",
      notificationType: json['notification_type'] ?? "-1",
      relatedUser: RelatedUser.fromJson(json['related_user']),
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
      comment: json.containsKey('comment') ? Comment.fromJson(json['comment']) : null,
      post: json.containsKey('post') ? Post.fromJson(json['post']) : null,
      userId: json['userId'] ?? "-1", 
      postId: json['postId'] ?? "-1", 
      commentId: json['commentId'] ?? "-1", 
    );
  }
}

class RelatedUser {
  final String username;
  final String avatarUrl;
  final bool newFollowers;
  final bool mentions;
  final bool upvotesComments;
  final bool upvotesPosts;
  final bool chatMessages;
  final bool chatRequests;
  final bool repliesToComments;
  final bool cakeDay;
  final bool modNotifications;
  final bool replies;
  final bool invitations;
  final bool posts;
  final bool inboxMessages;

  RelatedUser({
    required this.username,
    required this.avatarUrl,
    required this.newFollowers,
    required this.mentions,
    required this.upvotesComments,
    required this.upvotesPosts,
    required this.chatMessages,
    required this.chatRequests,
    required this.repliesToComments,
    required this.cakeDay,
    required this.modNotifications,
    required this.replies,
    required this.invitations,
    required this.posts,
    required this.inboxMessages,
  });

  factory RelatedUser.fromJson(Map<String, dynamic> json) {
    return RelatedUser(
      username: json['username'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      newFollowers: json['newFollowers'] ?? false,
      mentions: json['mentions'] ?? false,
      upvotesComments: json['upvotesComments'] ?? false,
      upvotesPosts: json['upvotesPosts'] ?? false,
      chatMessages: json['chatMessages'] ?? false,
      chatRequests: json['chatRequests'] ?? false,
      repliesToComments: json['repliesToComments'] ?? false,
      cakeDay: json['cakeDay'] ?? false,
      modNotifications: json['modNotifications'] ?? false,
      replies: json['replies'] ?? false,
      invitations: json['invitations'] ?? false,
      posts: json['posts'] ?? false,
      inboxMessages: json['inboxMessages'] ?? false,
    );
  }
}

class Post {
  final int id;
  final String title;
  final String community;

  Post({
    required this.id,
    required this.title,
    required this.community,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_Id'] ?? 0, // Provide a default integer value if null
      title: json['title'] ?? '',
      community: json['community'] ?? '',
    );
  }
}

class Comment {
  final String id;
  final String content;
  final String postTitle;
  final String communityTitle;

  Comment({
    required this.id,
    required this.content,
    required this.postTitle,
    required this.communityTitle,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '0', 
      content: json['content'] ?? '',
      postTitle: json['postTitle'] ?? '',
      communityTitle: json['communityTitle'] ?? '',
    );
  }
}
