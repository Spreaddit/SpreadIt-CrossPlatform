import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/NSFW_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/spoiler_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/unNSFW_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/unspoiler_post.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/delete_post_bottomsheet.dart';

import '../../../saved/data/save_or_unsave.dart';

void getReplyNotifications() {
  //TODO: get reply notifications logic
}

void subscribeToPost() {}

void hide() {}

void copyText() {
  //Copy logic
}
void save() {
  //TODO:Save comment logic
}
void collapseThread() {
  //TODO:Collaps thread logic
}
void blockAccount() {
  //TODO:Block logic
}

void report() {
  //TODO:Report logic
}

void markSpoiler(BuildContext context, int postId) async {
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

void unmarkSpoiler(BuildContext context, int postId) async {
  int response = await unspoilerPost(postId);
  if (response == 200) {
    Navigator.pop(context);
    CustomSnackbar(content: "Your post now is unmarked Spoiler");
  } else if (response == 500) {
    CustomSnackbar(content: 'Internal server error, try again later')
        .show(context);
  } else {
    CustomSnackbar(content: 'Post not found').show(context);
  }
}

void markNSFW(BuildContext context, int postId) async {
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

void unmarkNSFW(BuildContext context, int postId) async {
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

void deletePost(BuildContext context, int postId, void Function() onDeleted) {
  deletePostButtomSheet(context, postId, onDeleted);
}

void savePost(BuildContext context, int postId) async {
  int statusCode = await saveOrUnsave(id: '$postId', type: 'savepost');
  Navigator.pop(context);
  if (statusCode == 200) {
    print('Post unsaved successfully.');
  } else {
    CustomSnackbar(content: "Error occurred while trying to unsave")
        .show(context);
  }
}

void unsavePost(BuildContext context, int postId) async {
  int statusCode = await saveOrUnsave(id: '$postId', type: 'unsavepost');
  Navigator.pop(context);
  if (statusCode == 200) {
    print('Post unsaved successfully.');
  } else {
    CustomSnackbar(content: "Error occurred while trying to unsave")
        .show(context);
  }
}
