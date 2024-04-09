class Post {
  final int postId;
  final String userId;
  final String username;
  final String userProfilePic;
  final int votesUpCount;
  final int votesDownCount;
  final int sharesCount;
  final int commentsCount;
  final int numberOfViews;
  final DateTime date;
  final String title;
  final List<String> content;
  final String community;
  final String type;
  final List<PollOption> pollOptions;
  final String pollVotingLength;
  final DateTime pollExpiration;
  final bool isPollEnabled;
  final String link;
  final List<Attachment> attachments;
  final List<dynamic> comments;
  final List<dynamic> hiddenBy;
  final List<dynamic> votedUsers;
  final bool isSpoiler;
  final bool isCommentsLocked;
  final bool isNsfw;
  final bool sendPostReplyNotification;

  Post({
    required this.postId,
    required this.userId,
    required this.username,
    required this.userProfilePic,
    required this.votesUpCount,
    required this.votesDownCount,
    required this.sharesCount,
    required this.commentsCount,
    required this.numberOfViews,
    required this.date,
    required this.title,
    required this.content,
    required this.community,
    required this.type,
    required this.pollOptions,
    required this.pollVotingLength,
    required this.pollExpiration,
    required this.isPollEnabled,
    required this.link,
    required this.attachments,
    required this.comments,
    required this.hiddenBy,
    required this.votedUsers,
    required this.isSpoiler,
    required this.isCommentsLocked,
    required this.isNsfw,
    required this.sendPostReplyNotification,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      userId: json['userId'],
      username: json['username'],
      userProfilePic: json['userProfilePic'],
      votesUpCount: json['votesUpCount'],
      votesDownCount: json['votesDownCount'],
      sharesCount: json['sharesCount'],
      commentsCount: json['commentsCount'],
      numberOfViews: json['numberOfViews'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      content: List<String>.from(json['content']),
      community: json['community'],
      type: json['type'],
      pollOptions: (json['pollOptions'] as List<dynamic>?)
              ?.map((option) => PollOption.fromJson(option))
              .toList() ??
          [],
      pollVotingLength: json['pollVotingLength'],
      pollExpiration: DateTime.parse(json['pollExpiration']),
      isPollEnabled: json['isPollEnabled'],
      link: json['link'],
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((attachment) => Attachment.fromJson(attachment))
              .toList() ??
          [],
      comments: List<dynamic>.from(json['comments'] ?? []),
      hiddenBy: List<dynamic>.from(json['hiddenBy'] ?? []),
      votedUsers: List<dynamic>.from(json['votedUsers'] ?? []),
      isSpoiler: json['isSpoiler'],
      isCommentsLocked: json['isCommentsLocked'],
      isNsfw: json['isNsfw'],
      sendPostReplyNotification: json['sendPostReplyNotification'],
    );
  }
}

class PollOption {
  final String option;
  final int votes;

  PollOption({
    required this.option,
    required this.votes,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      option: json['option'],
      votes: json['votes'],
    );
  }
}

class Attachment {
  final String type;
  final String link;

  Attachment({
    required this.type,
    required this.link,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      type: json['type'],
      link: json['link'],
    );
  }
}
