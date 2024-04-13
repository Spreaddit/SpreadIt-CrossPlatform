class Post {
  final String postId;
  final String userId;
  final String username;
  final String userProfilePic;
  final int? votesUpCount;
  final int? votesDownCount;
  final int? sharesCount;
  final int? commentsCount;
  final int? numberOfViews;
  final DateTime date;
  final String? title;
  final List<String>? content;
  final String community;
  final String? type;
  final List<PollOptions>? pollOptions;
  final String? pollVotingLength;
  final DateTime? pollExpiration;
  final bool? isPollEnabled;
  final String? link;
  final List<Attachment>? attachments;
  final List<dynamic>? comments;
  final List<dynamic>? hiddenBy;
  final List<dynamic>? votedUsers;
  final bool? isSpoiler;
  final bool? isCommentsLocked;
  final bool? isNsfw;
  final bool? sendPostReplyNotification;

  Post({
    required this.postId,
    required this.userId,
    required this.username,
    required this.userProfilePic,
    this.votesUpCount,
    this.votesDownCount,
    this.sharesCount,
    this.commentsCount,
    this.numberOfViews,
    required this.date,
    this.title,
    this.content,
    required this.community,
    this.type,
    this.pollOptions,
    this.pollVotingLength,
    this.pollExpiration,
    this.isPollEnabled,
    this.link,
    this.attachments,
    this.comments,
    this.hiddenBy,
    this.votedUsers,
    this.isSpoiler,
    this.isCommentsLocked,
    this.isNsfw,
    this.sendPostReplyNotification,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['_id'],
      userId: json['userId'],
      username: json['username'] ?? "anonymous",
      userProfilePic:
          "https://i.pinimg.com/200x/16/ed/ff/16edfff4cfc69f8c58054793e2947aa0.jpg",
      votesUpCount: json['votesUpCount'],
      votesDownCount: json['votesDownCount'],
      sharesCount: json['sharesCount'],
      commentsCount: json['commentsCount'],
      numberOfViews: json['numberOfViews'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      community: json['community'],
      type: json['type'],
      pollOptions: (json['pollOptions'] as List<dynamic>?)
          ?.map((option) => PollOptions.fromJson(option))
          .toList(),
      pollVotingLength: json['pollVotingLength'],
      pollExpiration: json['pollExpiration'] != null
          ? DateTime.parse(json['pollExpiration'])
          : null,
      isPollEnabled: json['isPollEnabled'],
      link: json['link'],
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((attachment) => Attachment.fromJson(attachment))
          .toList(),
      comments: json['comments'] != null
          ? List<dynamic>.from(json['comments'])
          : null,
      hiddenBy: json['hiddenBy'] != null
          ? List<dynamic>.from(json['hiddenBy'])
          : null,
      votedUsers: json['votedUsers'] != null
          ? List<dynamic>.from(json['votedUsers'])
          : null,
      isSpoiler: json['isSpoiler'],
      isCommentsLocked: json['isCommentsLocked'],
      isNsfw: json['isNsfw'],
      sendPostReplyNotification: json['sendPostReplyNotification'],
    );
  }
}

class PollOptions {
  final String? option;
  final int? votes;

  PollOptions({
    this.option,
    this.votes,
  });

  factory PollOptions.fromJson(Map<String, dynamic> json) {
    return PollOptions(
      option: json['option'],
      votes: json['votes'],
    );
  }
}

class Attachment {
  final String? type;
  final String? link;

  Attachment({
    this.type,
    this.link,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      type: json['type'],
      link: json['link'],
    );
  }
}
