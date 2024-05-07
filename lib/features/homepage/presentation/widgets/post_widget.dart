import 'dart:async';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_join.dart';
import 'package:spreadit_crossplatform/features/dynamic_navigations/navigate_to_community.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_post_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/homepage/data/handle_polls.dart';
import 'package:spreadit_crossplatform/features/homepage/data/lock_comments.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/data/remove_spam.dart';
import 'package:spreadit_crossplatform/features/homepage/data/unlock_comments.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/on_more_functios.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:video_player/video_player.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

void navigateToPostCardPage({BuildContext context, String postId,
    bool isUserProfile, bool isModeratorView, bool canManagePostsAndComments}) {
void navigateToPostCardPage({
  required BuildContext context,
  required String postId,
  Post? post,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(
        name: '/post-card-page/$postId',
      ),
      builder: (context) => PostCardPage(
        postId: postId,
        isModeratorView: isModeratorView,
        canManagePostsAndComments: canManagePostsAndComments,
        post: post,
      ),
    ),
  );
}

/// This widget represents the header section of a post, including details like community, username, date, and actions.
/// It also renders the post menu based on whether the user is the owner of the post or a viewer.
class _PostHeader extends StatefulWidget {
  final Post post;
  final bool isUserProfile;
  final String? content;
  final void Function(String) onContentChanged;
  final bool isNsfw;
  final bool isSpoiler;
  final bool isSaved;
  final bool isLocked;
  final void Function(bool) onNsfwChanged;
  final void Function(bool) onSpoilerChanged;
  final void Function() onDeleted;
  final void Function(bool) onsaved;
  final BuildContext? feedContext;

  _PostHeader({
    required this.post,
    required this.onContentChanged,
    required this.isUserProfile,
    required this.isNsfw,
    required this.isSpoiler,
    required this.isSaved,
    required this.isLocked,
    required this.onsaved,
    required this.onSpoilerChanged,
    required this.onNsfwChanged,
    required this.onDeleted,
    this.content = "",
    this.feedContext,
  });

  @override
  State<_PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<_PostHeader> {
  late String dateFormatted;
  late Timer timer;
  bool shouldRenderJoin = false;

  bool isAdmin = UserSingleton().user?.role == "Admin";

  @override
  void initState() {
    super.initState();
    setState(() {
      dateFormatted = dateToDuration(widget.post.date);
    });
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        dateFormatted = dateToDuration(widget.post.date);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(top: -10),
          title: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => navigateToCommunity(
                  context,
                  widget.post.community,
                ),
                child: Text(
                  "r/${widget.post.community}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Text(dateFormatted),
            ],
          ),
          subtitle: GestureDetector(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  settings: RouteSettings(
                    name: '/user-profile/${widget.post.username}',
                  ),
                  builder: (context) => UserProfile(
                    username: widget.post.username,
                  ),
                ),
              ),
            },
            child: Text(widget.post.username),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.post.userProfilePic),
          ),
          trailing: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: shouldRenderJoin ? 1 : 0,
                child: JoinCommunityBtn(
                  shouldJoinButtonRender: () {
                    if (!mounted) return;
                    setState(() {
                      shouldRenderJoin = true;
                    });
                  },
                  communityName: widget.post.community,
                ),
              ),
              if (widget.isLocked) Icon(Icons.lock, color: Colors.orange),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: onShowMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onShowMenu() {
    List<String> viewerOptions = [
      widget.isSaved ? "Unsave" : "Save",
      "Copy text",
      "Report",
      "Block account",
      "Hide",
    ];
    List<String> writerOptions = [
      widget.isSaved ? "Unsave" : "Save",
      "Copy text",
      "Hide",
      "Edit post",
      widget.isSpoiler ? "Unmark Spoiler" : "Mark Spoiler",
      widget.isNsfw ? "Unmark NSFW" : "Mark NSFW",
      "Delete post",
    ];

    List<void Function()> writerActions = [
      widget.isSaved
          ? () => {
                unsavePost(
                  context,
                  widget.post.postId,
                ),
                widget.onsaved(!widget.isSaved),
              }
          : () => {
                savePost(
                  context,
                  widget.post.postId,
                ),
                widget.onsaved(!widget.isSaved),
              },
      () => copyText(context, widget.content!),
      hide,
      () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPost(
                postId: widget.post.postId.toString(),
                postContent: widget.post.content != null &&
                        widget.post.content!.isNotEmpty
                    ? widget.post.content![widget.post.content!.length - 1]
                    : "",
                onContentChanged: widget.onContentChanged,
                communityName: widget.post.community,
              ),
            ),
          ),
      widget.isSpoiler
          ? () => {
                widget.onSpoilerChanged(!widget.isSpoiler),
                unmarkSpoiler(context, widget.post.postId),
              }
          : () => {
                widget.onSpoilerChanged(!widget.isSpoiler),
                markSpoiler(context, widget.post.postId),
              },
      widget.isNsfw
          ? () => {
                widget.onNsfwChanged(!widget.isNsfw),
                unmarkNSFW(context, widget.post.postId),
              }
          : () => {
                widget.onNsfwChanged(!widget.isNsfw),
                markNSFW(context, widget.post.postId),
              },
      () => deletePost(
            widget.feedContext ?? context,
            widget.post.postId,
            widget.onDeleted,
          ),
    ];

    List<void Function()> viewerActions = [
      widget.isSaved
          ? () => {
                unsavePost(
                  context,
                  widget.post.postId,
                ),
                widget.onsaved(!widget.isSaved),
              }
          : () => {
                savePost(
                  context,
                  widget.post.postId,
                ),
                widget.onsaved(!widget.isSaved),
              },
      () => copyText(context, widget.content!),
      () => report(
            context,
            widget.post.community,
            widget.post.postId.toString(),
            '0',
            widget.post.username,
            true,
          ),
      () => blockAccount(widget.post.username),
      hide
    ];

    List<IconData> writerIcons = [
      Icons.save,
      Icons.copy,
      Icons.hide_source_rounded,
      Icons.edit,
      Icons.new_releases_rounded,
      Icons.warning_rounded,
      Icons.delete,
    ];
    List<IconData> viewerIcons = [
      Icons.save,
      Icons.copy,
      Icons.flag,
      Icons.block,
      Icons.hide_source_rounded,
    ];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          icons: widget.isUserProfile || isAdmin ? writerIcons : viewerIcons,
          text: widget.isUserProfile || isAdmin ? writerOptions : viewerOptions,
          onPressedList:
              widget.isUserProfile || isAdmin ? writerActions : viewerActions,
        );
      },
    );
  }
}

/// This widget is responsible for displaying post body:
/// headline, content (all types)
class _PostBody extends StatelessWidget {
  final String title;
  final String postType;
  final String? content;
  final List<Attachment>? attachments;
  final String? link;
  final bool isFullView;
  final List<PollOptions>? pollOption;
  final String? pollVotingLength;
  final bool? isPollEnabled;
  final String postId;
  final bool isSpoiler;
  final bool isNsfw;
  final bool? hasVotedOnPoll;
  final String? selectedPollOption;

  _PostBody({
    required this.title,
    required this.postType,
    this.content,
    this.attachments,
    this.link,
    required this.isFullView,
    this.isPollEnabled,
    this.pollOption,
    this.pollVotingLength,
    required this.postId,
    this.isNsfw = false,
    this.isSpoiler = false,
    this.hasVotedOnPoll = false,
    this.selectedPollOption,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.6,
              child: Row(
                children: [
                  isNsfw
                      ? Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.eighteen_up_rating_rounded,
                              color: Colors.purple,
                              size: 16,
                            ),
                            Text(
                              " Nswf",
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        )
                      : Text(""),
                  SizedBox(
                    width: isNsfw ? 10 : 0,
                  ),
                  isSpoiler
                      ? Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.explicit,
                              size: 16,
                            ),
                            Text(
                              " Spoiler",
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Text(""),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _PostContent(
              postType: postType,
              content: content,
              attachments: attachments,
              link: link,
              isFullView: isFullView,
              pollOption: pollOption,
              isPollEnabled: isPollEnabled ?? true,
              pollVotingLength: pollVotingLength,
              postId: postId,
              isNsfw: isNsfw,
              isSpoiler: isSpoiler,
              selectedPollOption: selectedPollOption,
              hasVotedOnPoll: hasVotedOnPoll,
            ),
          ],
        ),
      ),
    );
  }
}

/// This widget is responsible for displaying a carousel of images.
/// It takes a list of attachments (images) as input and
/// displays them in a horizontal carousel format, allowing
/// users to swipe through the images.
class _ImageCaruosel extends StatefulWidget {
  final List<Attachment> attachments;
  _ImageCaruosel({
    required this.attachments,
  });

  @override
  State<_ImageCaruosel> createState() => _ImageCaruoselState();
}

class _ImageCaruoselState extends State<_ImageCaruosel> {
  int _currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width / (16 / 9),
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                if (!mounted) return;

                _currentImageIndex = index;
              });
            },
          ),
          items: widget.attachments.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage(i.link!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.attachments.asMap().entries.map((entry) {
            return Container(
              width: 20.0,
              height: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: entry.key == _currentImageIndex
                    ? Color.fromARGB(255, 255, 68, 0)
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// This widget is responsible for displaying the content of a post.
/// It adapts its layout and rendering based on the type of post,
/// which can be an image, video, poll, or text.
class _PostContent extends StatelessWidget {
  final String postType;
  final String? content;
  final List<PollOptions>? pollOption;
  final String? pollVotingLength;
  final bool isPollEnabled;
  final List<Attachment>? attachments;
  final String? link;
  final bool isFullView;
  final String postId;
  final bool isSpoiler;
  final bool isNsfw;
  final bool? hasVotedOnPoll;
  final String? selectedPollOption;

  _PostContent({
    required this.postType,
    required this.isFullView,
    this.content,
    this.attachments,
    this.link,
    this.isPollEnabled = true,
    this.pollOption,
    this.pollVotingLength,
    required this.postId,
    this.isNsfw = false,
    this.isSpoiler = false,
    this.hasVotedOnPoll = false,
    this.selectedPollOption,
  });

  @override
  Widget build(BuildContext context) {
    print(postType);
    if (postType == "Post") {
      if ((isNsfw || isSpoiler) && !isFullView) return Text("");

      return Text(
        content ?? "",
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: !isFullView ? 5 : 2000,
      );
    } else if (postType == "Images & Video") {
      if ((isNsfw || isSpoiler) && !isFullView) return Text("");

      if (attachments!.isNotEmpty) {
        if (attachments![0].type == "image") {
          return _ImageCaruosel(attachments: attachments!);
        } else {
          return VideoPlayerScreen(videoURL: attachments![0].link!);
        }
      } else {
        CustomSnackbar(content: "No Attachments Found").show(context);
        print("Error fetching attachments from back");
        return Text("Unable to load attachments");
      }
    } else if (postType == "Link") {
      if ((isNsfw || isSpoiler) && !isFullView) return Text("");
      print("link is:$link");
      return AnyLinkPreview(
        link: link ?? "",
        displayDirection: UIDirection.uiDirectionHorizontal,
        cache: Duration(hours: 1),
        backgroundColor: Colors.grey[300],
        proxyUrl: kIsWeb ? "https://corsproxy.io/?" : null,
        errorWidget: Container(
          color: Colors.grey[300],
          child: Text('Oops!'),
        ),
      );
    } else {
      if ((isNsfw || isSpoiler) && !isFullView) return Text("");
      if (pollOption == null || pollOption!.length < 2) {
        return Text("Oops. something went wrong");
      }

      print("has voted ahoooo $hasVotedOnPoll $selectedPollOption");
      return FlutterPolls(
        pollTitle: Text(""),
        pollId: Uuid().v1(),
        hasVoted: hasVotedOnPoll ?? false,
        userVotedOptionId: selectedPollOption != null
            ? pollOption!
                .indexWhere((element) => element.option == selectedPollOption)
                .toString()
            : "0",
        onVoted: (chosenPollOption, newTotalVotes) {
          return handlePolls(
              postId: postId,
              pollOption: PollOptions(
                option:
                    pollOption![int.parse(chosenPollOption.id ?? "0")].option,
                votes: newTotalVotes,
              ));
        },
        pollOptionsSplashColor: Colors.white,
        pollEnded: !isPollEnabled,
        votedProgressColor: Colors.grey,
        votedBackgroundColor: Colors.grey.withOpacity(0.2),
        leadingVotedProgessColor: Color.fromARGB(230, 255, 68, 0),
        pollOptions: pollOption!.mapIndexed(
          (index, option) {
            return PollOption(
              id: index.toString(),
              title: Text(
                option.option!,
              ),
              votes: option.votes!,
            );
          },
        ).toList(),
      );
    }
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoURL;

  const VideoPlayerScreen({
    Key? key,
    required this.videoURL,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    );
    flickManager = FlickManager(videoPlayerController: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FlickVideoPlayer(
        flickManager: flickManager,
      ),
    );
  }
}

/// This widget is responsible for displaying post interactions bottom bar
/// count of shares, upvotes and comments is displayed here.
class _PostInteractions extends StatefulWidget {
  final String communityName;
  final int votesCount;
  final int sharesCount;
  final int commentsCount;
  final bool isUserProfile;
  final String postId;
  final bool isFullView;
  final bool hasUpvoted;
  final bool hasDownvoted;
  final bool isModeratorView;
  bool isCommentsLocked;
  bool canManagePosts;
  final void Function(bool) onLock;
  final Post post;

  _PostInteractions({
    required this.communityName,
    required this.votesCount,
    required this.sharesCount,
    required this.commentsCount,
    required this.isUserProfile,
    required this.postId,
    required this.isFullView,
    required this.hasUpvoted,
    required this.hasDownvoted,
    required this.isModeratorView,
    required this.isCommentsLocked,
    required this.onLock,
    required this.canManagePosts,
    required this.post,
  });
  @override
  State<_PostInteractions> createState() => _PostInteractionsState();
}

class _PostInteractionsState extends State<_PostInteractions> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            VoteButton(
              initialVotesCount: widget.votesCount,
              isUpvoted: widget.hasUpvoted,
              isDownvoted: widget.hasDownvoted,
              postId: widget.postId,
            ),
            widget.isCommentsLocked
                ? TextButton.icon(
                    onPressed: () => navigateToPostCardPage(
                      context,
                      widget.postId,
                      widget.isUserProfile,
                      widget.isModeratorView,
                      widget.canManagePosts,
                    ),
                    icon: Icon(
                      Icons.comment,
                      color:  Colors.grey,
                    ),
                    label: Text(
                      widget.commentsCount.toString(),
                    ),
                  )
                : TextButton.icon(
                    onPressed: () => navigateToPostCardPage(
                      context,
                      widget.postId,
                      widget.isUserProfile,
                      widget.isModeratorView,
                      widget.canManagePosts,
                    ),
                    icon: Icon(
                      Icons.comment,
                    ),
                    label: Text(
                      widget.commentsCount.toString(),
                    ),
                  ),
            TextButton.icon(
              onPressed: () => navigateToPostCardPage(
                context: context,
                postId: widget.post.postId,
                post: widget.post,
              ),
              icon: Icon(
                Icons.comment,
              ),
              label: Text(
                widget.commentsCount.toString(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => sharePressed("should render"),
            ),
            if (widget.isModeratorView && widget.canManagePosts)
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomBottomSheet(
                        icons: [
                          Icons.lock,
                          Icons.delete,
                        ],
                        text: [
                          widget.isCommentsLocked
                              ? "unlock comments"
                              : "Lock comments",
                          "Remove as spam",
                        ],
                        onPressedList: [
                          () {
                            //Lock comments
                            setState(() {
                              widget.isCommentsLocked
                                  ? unlockComments(postId: widget.postId)
                                  : lockComments(postId: widget.postId);
                              widget.isCommentsLocked =
                                  !widget.isCommentsLocked;
                              widget.onLock(widget.isCommentsLocked);
                              Navigator.pop(context);
                              widget.isCommentsLocked
                                  ? CustomSnackbar(
                                          content:
                                              "Comments on this post are locked successfully!")
                                      .show(context)
                                  : CustomSnackbar(
                                          content:
                                              "Comments on this post are unlocked successfully!")
                                      .show(context);
                            });
                          },
                          () {
                            setState(() {
                              removeAsSpam(
                                  communityName: widget.communityName,
                                  postId: widget.postId);
                              Navigator.pop(context);
                              CustomSnackbar(
                                      content: "Post will be removed as spam!")
                                  .show(context);
                            });
                          },
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.shield,
                ),
              )
            else if (widget.isModeratorView && !widget.canManagePosts)
              IconButton(
                onPressed: () {
                  CustomSnackbar(
                          content: "You are not authorized to manage posts!")
                      .show(context);
                },
                icon: Icon(
                  Icons.shield,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// This widget represents a post card with relevant information.
/// It takes the following parameters:
/// 1. [post]: An instance of [Post] containing post details.
/// 2. [isFullView]: A boolean indicating whether to render the post in full view or post feed view.
/// 3. [isUserProfile]: A boolean indicating whether to render the post as a post owner or viewer.
///
/// Example:
/// ```dart
/// PostWidget(
///   post: myPost,
///   isFullView: true,
///   isUserProfile: true,
/// )
/// ```
class PostWidget extends StatefulWidget {
  final Post post;
  final bool isFullView;
  final bool isUserProfile;
  final bool isSavedPage;
  final bool isModeratorView;
  final bool canManagePosts;
  final BuildContext? feedContext;

  PostWidget({
    required this.post,
    this.isFullView = false,
    required this.isUserProfile,
    this.isSavedPage = false,
    this.feedContext,
    this.isModeratorView = false,
    this.canManagePosts = false,
  });
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late List<String> content;
  late bool isNsfw;
  late bool isSpoiler;
  late bool isDeleted = false;
  late bool isSaved;
  late bool isCommentsLocked;

  @override
  void initState() {
    super.initState();
    setState(() {
      isNsfw = widget.post.isNsfw!;
      isSpoiler = widget.post.isSpoiler!;
      isSaved = widget.post.isSaved!;
      isCommentsLocked = widget.post.isCommentsLocked!;
      content = widget.post.content != null && widget.post.content!.isNotEmpty
          ? widget.post.content!
          : [];
    });
  }

  void onDeleted() {
    if (!mounted) return;

    if (widget.isFullView) {
      Navigator.of(context).pushNamed('/home');
    }
    setState(() {
      isDeleted = true;
    });
  }

  void onContentChanged(String newContent) {
    if (!mounted) return;

    setState(() {
      content.add(newContent);
    });
  }

  void onLock(bool newIsCommentsLocked) {
    if (!mounted) return;
    print(newIsCommentsLocked);
    setState(() {
      isCommentsLocked = newIsCommentsLocked;
    });
  }

  void onChangeSpoiler(bool newIsSpoiler) {
    if (!mounted) return;

    setState(() {
      isSpoiler = newIsSpoiler;
    });
  }

  void onSaved(bool newIsSaved) {
    if (!mounted) return;

    setState(() {
      isSaved = newIsSaved;
    });
  }

  void onChangeNsfw(bool newIsNsfw) {
    if (!mounted) return;

    setState(() {
      isNsfw = newIsNsfw;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isSavedPage && !isSaved)
        ? Center(
            child: Text("Post Has Been Unsaved"),
          )
        : (!isDeleted)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PostHeader(
                    post: widget.post,
                    onContentChanged: onContentChanged,
                    isUserProfile: widget.isUserProfile,
                    isNsfw: isNsfw,
                    isSpoiler: isSpoiler,
                    isSaved: isSaved,
                    isLocked: isCommentsLocked,
                    onsaved: onSaved,
                    onNsfwChanged: onChangeNsfw,
                    onSpoilerChanged: onChangeSpoiler,
                    onDeleted: onDeleted,
                    feedContext: widget.feedContext,
                    content: widget.post.content != null &&
                            widget.post.content!.isNotEmpty
                        ? widget.post.content![widget.post.content!.length - 1]
                        : widget.post.title,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("tapped");
                      if (!widget.isFullView) {
                        navigateToPostCardPage(
                          context: context,
                          postId: widget.post.postId,
                          post: widget.post,
                          isModeratorView:widget.isModeratorView,
                           canManagePosts:widget.canManagePosts,
                        );
                      }
                    },
                    child: _PostBody(
                      title: widget.post.title!,
                      content: widget.post.content != null &&
                              widget.post.content!.isNotEmpty
                          ? widget
                              .post.content![widget.post.content!.length - 1]
                          : "",
                      attachments: widget.post.attachments,
                      link: widget.post.link,
                      postType: widget.post.type!,
                      isFullView: widget.isFullView,
                      pollOption: widget.post.pollOptions,
                      isPollEnabled: widget.post.isPollEnabled,
                      pollVotingLength: widget.post.pollVotingLength,
                      postId: widget.post.postId,
                      isNsfw: isNsfw,
                      isSpoiler: isSpoiler,
                    ),
                  ),
                  _PostInteractions(
                    postId: widget.post.postId,
                    communityName: widget.post.community,
                    isUserProfile: widget.isUserProfile,
                    votesCount:
                        widget.post.votesUpCount! - widget.post.votesDownCount!,
                    sharesCount: widget.post.sharesCount!,
                    commentsCount: widget.post.commentsCount!,
                    isFullView: widget.isFullView,
                    hasDownvoted: widget.post.hasDownvoted ?? false,
                    hasUpvoted: widget.post.hasUpvoted ?? false,
                    isModeratorView: widget.isModeratorView,
                    canManagePosts: widget.canManagePosts,
                    isCommentsLocked: isCommentsLocked,
                    onLock: onLock,
                    post: widget.post,
                  )
                ],
              )
            : Center(
                child: Text("Post Has Been Deleted"),
              );
  }
}
