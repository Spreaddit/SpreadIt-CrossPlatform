import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/dynamic_navigations/navigate_to_community.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';
import '../../../generic_widgets/bottom_model_sheet.dart';
import '../../../generic_widgets/snackbar.dart';
import '../../../homepage/presentation/widgets/date_to_duration.dart';
import '../../../saved/data/save_or_unsave.dart';

/// The `CommentWidget` class is responsible for displaying a single comment within a user interface.
///
/// This widget typically represents a comment made by a user on a post or within a discussion thread.
class CommentWidget extends StatelessWidget {
  /// The comment object containing information such as post title, user details, subreddit name, creation date, content, and media.
  final Comment comment;

  /// Boolean value indicating whether the comment is saved.
  final bool saved;

  /// Callback function triggered when the user interacts with the widget.
  final VoidCallback? onPressed;
  final bool isUserProfile;

  /// Constructor for the `CommentWidget` class.
  ///
  /// Parameters:
  /// - `comment`: The comment object containing information such as post title, user details, subreddit name, creation date, content, and media.
  /// - `saved`: Boolean value indicating whether the comment is saved. Defaults to `false`.
  /// - `onPressed`: Callback function triggered when the user interacts with the widget. Defaults to `null`.
  CommentWidget({
    required this.comment,
    this.saved = false,
    this.onPressed,
    this.isUserProfile = false, /////// Check
  });

  void unsaveComment(BuildContext context) async {
    int statusCode = await saveOrUnsave(id: comment.id, type: 'comments');
    Navigator.pop(context);
    if (statusCode == 200) {
      print('Comment unsaved successfully.');
      if (onPressed != null) {
        onPressed!();
      }
    } else {
      CustomSnackbar(content: "Error occurred while trying to unsave")
          .show(context);
    }
  }

  void navigateToPostCardPage(
    BuildContext context,
    String postId,
    bool isUserProfile,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(
          name: '/post-card-page/$postId/$isUserProfile',
        ),
        builder: (context) => PostCardPage(
          postId: postId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final date = dateToDuration(comment.createdAt);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: saved ? Colors.grey[200]! : Colors.grey,
                  width: saved ? screenHeight * 0.01 : screenHeight * 0.001,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateToPostCardPage(
                      context,
                      comment.postId!,
                      isUserProfile,
                    );
                  },
                  child: Text(
                    comment.postTitle!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    if (saved)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: RouteSettings(
                                name: '/user-profile/${comment.user!.username}',
                              ),
                              builder: (context) => UserProfile(
                                username: comment.user!.username,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'u/${comment.user!.username} • ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        navigateToCommunity(context, comment.subredditName!);
                      },
                      child: Text(
                        'r/${comment.subredditName} • $date',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    if (!saved)
                      Row(
                        children: [
                          Text(
                            '• ${comment.likesCount} ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              "assets/images/upvoteicon.png",
                              height: screenHeight * 0.015,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    navigateToPostCardPage(
                      context,
                      comment.postId!,
                      isUserProfile,
                    );
                  },
                  child: Text(
                    comment.content,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                if (comment.media!.isNotEmpty)
                  SizedBox(height: screenHeight * 0.02),
                if (comment.media!.isNotEmpty)
                  Image.network(comment.media![0].link),
              ],
            ),
          ),
          if (saved)
            CommentFooter(
              onMorePressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomBottomSheet(
                      icons: [
                        Icons.share,
                        Icons.bookmarks_outlined,
                        CupertinoIcons.bell_solid
                      ],
                      text: ['Share', 'Unsave', 'Get reply notifications'],
                      onPressedList: [
                        () {
                          Navigator.pop(context);
                          sharePressed('Profile Link isa');
                        },
                        () => unsaveComment(context),
                        () => {
                              Navigator.pop(context),
                            }
                      ],
                    );
                  },
                );
              },
              onReplyPressed: () {},
              number: comment.likesCount,
              upvoted: false,
              downvoted: false,
              postId: comment.postId,
              commentId: comment.id,
              isSaved: true,
            ),
        ],
      ),
    );
  }
}
