class Post {
  final int postId;
  final String userId;
  final String username;
  final String userProfilePic;
  final String profilePic;
  final int votesUpCount;
  final int votesDownCount;
  final int sharesCount;
  final int commentsCount;
  final int numberOfViews;
  final DateTime date;
  final String title;
  final List<String>? content;
  final String community;
  final String type;
  final List<PollOption>? pollOptions;
  final String? pollVotingLength;
  final DateTime? pollExpiration;
  final bool? isPollEnabled;
  final String? link;
  final List<Attachment>? attachments;
  final bool isSpoiler;
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
    required this.profilePic,
    required this.date,
    required this.title,
    required this.content,
    required this.community,
    required this.type,
    this.pollOptions,
    this.pollVotingLength,
    this.pollExpiration,
    this.isPollEnabled,
    this.link,
    this.attachments,
    required this.isSpoiler,
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
      pollOptions: json['pollOptions'] != null
          ? List<PollOption>.from(
              json['pollOptions'].map((x) => PollOption.fromJson(x)))
          : null,
      pollVotingLength: json['pollVotingLength'],
      pollExpiration: json['pollExpiration'] != null
          ? DateTime.parse(json['pollExpiration'])
          : null,
      isPollEnabled: json['isPollEnabled'],
      link: json['link'],
      attachments: json['attachments'] != null
          ? List<Attachment>.from(
              json['attachments'].map((x) => Attachment.fromJson(x)))
          : null,
      isSpoiler: json['isSpoiler'],
      isNsfw: json['isNsfw'],
      sendPostReplyNotification: json['sendPostReplyNotification'],
      profilePic: json['profilePic'],
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
  final String link;
  final String type; // 'image' or 'video'

  Attachment({
    required this.link,
    required this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      link: json['link'],
      type: json['type'],
    );
  }
}
