import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/mute_or_unmute_user.dart'; // Import necessary dependencies

void muteUser(BuildContext context, String username, String communityName,
    String type, String note) async {
  print('community name $communityName');
  username = username.replaceFirst('u/', '');
  int statusCode = await muteOrUnmuteUser(communityName, username, type, note);

  switch (statusCode) {
    case 200:
      showSnackbar(context, "User ${type}d successfully");
      break;
    case 400:
      showSnackbar(context, "Invalid data");
      break;
    case 401:
      showSnackbar(context, "Unauthorized");
      break;
    case 402:
      showSnackbar(context, "Not a moderator");
      break;
    case 404:
      showSnackbar(context, "Community or User not found");
      break;
    case 500:
      showSnackbar(context, "Internal server error");
      break;
    default:
      showSnackbar(context, "Unknown error occurred");
  }
}

void showSnackbar(BuildContext context, String message) {
  Navigator.pop(context);
  CustomSnackbar(content: message).show(context);
}
