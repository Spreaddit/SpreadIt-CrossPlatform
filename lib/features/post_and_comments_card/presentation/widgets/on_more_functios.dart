import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/NSFW_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/hide_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/spoiler_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/unNSFW_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/unspoiler_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/delete_post_bottomsheet.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/report_modal.dart';
import 'package:spreadit_crossplatform/features/user_interactions/data/user_interactions/user_to_user/interact.dart';

import '../../../saved/data/save_or_unsave.dart';

void hide({
  required BuildContext context,
  required String postId,
  required bool shouldHide,
  required void Function() onHide,
}) async {
  var response = await hidePost(postId, shouldHide);
  if (response != 200) {
    CustomSnackbar(content: "An error occured").show(context);
  }
}

void copyText(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(
    text: text,
  ));
  CustomSnackbar(
    content: "copied to clipboard",
  ).show(context);
  Navigator.of(context).pop();
}

void blockAccount(String username) {
  interactWithUser(
    userId: username,
    action: InteractWithUsersActions.block,
  );
}

void report(BuildContext context, String communityName, String postId,
    String commentId, String username, bool isPost) {
  ReportModal(
      context, communityName, postId, commentId, isPost, false, username);
}

void markSpoiler(BuildContext context, String postId) async {
  int response = await spoilerPost(postId);
  if (response == 200) {
    Navigator.pop(context);
    CustomSnackbar(content: "Your post now is marked Spoiler");
  } else if (response == 500) {
    CustomSnackbar(content: 'Internal server error, try again later')
        .show(context);
  } else {
    CustomSnackbar(content: 'Post not found').show(context);
  }
}

void unmarkSpoiler(BuildContext context, String postId) async {
  int response = await unspoilerPost(postId);
  if (response == 200) {
    Navigator.pop(context);
    CustomSnackbar(content: "Your post now is unmarked Spoiler");
  } else if (response == 500) {
    CustomSnackbar(content: 'An error occured').show(context);
  } else {
    CustomSnackbar(content: 'Post not found').show(context);
  }
}

void markNSFW(BuildContext context, String postId) async {
  int response = await NSFWPost(postId);
  if (response == 200) {
    Navigator.pop(context);
    CustomSnackbar(content: "Your post now is marked NSFW");
  } else if (response == 500) {
    CustomSnackbar(content: 'Internal server error, try again later')
        .show(context);
  } else {
    CustomSnackbar(content: 'Post not found').show(context);
  }
}

void unmarkNSFW(BuildContext context, String postId) async {
  int response = await unNSFWPost(postId);
  if (response == 200) {
    Navigator.pop(context);
    CustomSnackbar(content: "Your post now is unmarked NSFW");
  } else if (response == 500) {
    CustomSnackbar(content: 'Internal server error, try again later')
        .show(context);
  } else {
    CustomSnackbar(content: 'Post not found').show(context);
  }
}

void deletePost(
    BuildContext context, String postId, void Function() onDeleted) {
  deletePostButtomSheet(context, postId, onDeleted);
}

///function to fetch save post
void savePost(BuildContext context, String postId) async {
  int statusCode = await saveOrUnsave(id: postId, type: 'savepost');
  Navigator.pop(context);
  if (statusCode == 200) {
    CustomSnackbar(content: 'Post saved successfully.').show(context);
  } else {
    CustomSnackbar(content: "Error occurred while trying to unsave")
        .show(context);
  }
}

///function to fetch unsave post
void unsavePost(BuildContext context, String postId) async {
  int statusCode = await saveOrUnsave(id: '$postId', type: 'unsavepost');
  Navigator.pop(context);
  if (statusCode == 200) {
    CustomSnackbar(content: 'Post unsaved successfully.').show(context);
  } else {
    CustomSnackbar(
            content:
                "Error occurred while trying to unsave, Please try again later")
        .show(context);
  }
}

void saveOrUnsaveComment(BuildContext context, String id, bool isSaved) async {
  int statusCode = await saveOrUnsave(id: id, type: 'comments');
  Navigator.pop(context);
  if (statusCode == 200) {
    print('Comment unsaved/saved successfully.');
    String content;
    isSaved
        ? content = 'Comment Unsaved successfully'
        : content = 'Comment Saved successfully';
    CustomSnackbar(content: content).show(context);
  } else {
    CustomSnackbar(content: "Error occurred Please Try again later")
        .show(context);
  }
}
