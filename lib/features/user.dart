class User {
  String id;
  String name;
  String username;
  String email;
  String avatarUrl;
  String backgroundPictureUrl;
  String bio;
  int followersCount;
  int followingCount;
  DateTime createdAt;
  bool nsfw;
  bool activeInCommunityVisibility;
  bool clearHistory;
  bool allowFollow;
  List<String> blockedUsers;
  List<String> mutedCommunities;
  DateTime resetPasswordCodeExpiration;
  bool newFollowers;
  bool chatRequestEmail;
  bool unsubscribeAllEmails;
  List<String> communityContentSort;
  String globalContentView;
  bool communityThemes;
  bool autoplayMedia;
  bool adultContent;
  bool openPostsInNewTab;
  bool mentions;
  bool commentsOnYourPost;
  bool commentsYouFollow;
  bool upvotesComments;
  bool upvotesPosts;
  bool newFollowerEmail;
  bool replies;
  bool invitations;
  bool posts;
  String about;
  List<String> approvedUsers;
  String sendYouFriendRequests;
  String sendYouPrivateMessages;
  bool markAllChatsAsRead;
  bool inboxMessages;
  bool chatMessages;
  bool chatRequests;
  bool repliesToComments;
  bool cakeDay;
  String modNotifications;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.backgroundPictureUrl,
    required this.bio,
    required this.followersCount,
    required this.followingCount,
    required this.createdAt,
    required this.nsfw,
    required this.activeInCommunityVisibility,
    required this.clearHistory,
    required this.allowFollow,
    required this.blockedUsers,
    required this.mutedCommunities,
    required this.resetPasswordCodeExpiration,
    required this.newFollowers,
    required this.chatRequestEmail,
    required this.unsubscribeAllEmails,
    required this.communityContentSort,
    required this.globalContentView,
    required this.communityThemes,
    required this.autoplayMedia,
    required this.adultContent,
    required this.openPostsInNewTab,
    required this.mentions,
    required this.commentsOnYourPost,
    required this.commentsYouFollow,
    required this.upvotesComments,
    required this.upvotesPosts,
    required this.newFollowerEmail,
    required this.replies,
    required this.invitations,
    required this.posts,
    required this.about,
    required this.approvedUsers,
    required this.sendYouFriendRequests,
    required this.sendYouPrivateMessages,
    required this.markAllChatsAsRead,
    required this.inboxMessages,
    required this.chatMessages,
    required this.chatRequests,
    required this.repliesToComments,
    required this.cakeDay,
    required this.modNotifications,
  });

User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        avatarUrl = json['avatar_url'],
        backgroundPictureUrl = json['background_picture_url'],
        bio = json['bio'],
        followersCount = json['followers_count'] as int,
        followingCount = json['following_count']  as int,
        createdAt = DateTime.parse(json['created_at']),
        nsfw = json['nsfw'] as bool,
        activeInCommunityVisibility = json['activeInCommunityVisibility'] as bool,
        clearHistory = json['clearHistory'] as bool ,
        allowFollow = json['allowFollow'] as bool ,
        blockedUsers = List<String>.from(json['blockedUsers']),
        mutedCommunities = List<String>.from(json['mutedCommunities']),
        resetPasswordCodeExpiration = DateTime.parse(json['resetPasswordCodeExpiration']),
        newFollowers = json['newFollowers'] as bool ,
        chatRequestEmail = json['chatRequestEmail']as bool,
        unsubscribeAllEmails = json['unsubscribeAllEmails']as bool,
        communityContentSort = json['communityContentSort'] as List<String>,
        globalContentView = json['globalContentView'] as String,
        communityThemes = json['communityThemes'] as bool ,
        autoplayMedia = json['autoplayMedia'] as bool,
        adultContent = json['adultContent'] as bool,
        openPostsInNewTab = json['openPostsInNewTab'] as bool,
        mentions = json['mentions']as bool,
        commentsOnYourPost = json['commentsOnYourPost'] as bool,
        commentsYouFollow = json['commentsYouFollow'] as bool,
        upvotesComments = json['upvotesComments']as bool,
        upvotesPosts = json['upvotesPosts']as bool,
        newFollowerEmail = json['newFollowerEmail']as bool,
        replies = json['replies']as bool,
        invitations = json['invitations']as bool,
        posts = json['posts']as bool,
        about = json['about'] as String,
        approvedUsers = List<String>.from(json['approvedUsers']),
        sendYouFriendRequests = json['sendYouFriendRequests'] as String,
        sendYouPrivateMessages = json['sendYouPrivateMessages']as String,
        markAllChatsAsRead = json['markAllChatsAsRead'] as bool,
        inboxMessages = json['inboxMessages'] as bool,
        chatMessages = json['chatMessages']as bool,
        chatRequests = json['chatRequests']as bool,
        repliesToComments = json['repliesToComments']as bool,
        cakeDay = json['cakeDay']as bool,
        modNotifications = json['modNotifications'] as String;

}