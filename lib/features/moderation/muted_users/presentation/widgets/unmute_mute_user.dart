import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/mute_or_unmute_user.dart'; // Import necessary dependencies

/// Mutes or unmutes a user within a community.
///
/// This function sends a request to the backend API to mute or unmute a user
/// within the specified community. It takes the following parameters:
///
/// - `context`: The build context used for showing snackbar notifications.
/// - `username`: The username of the user to be muted or unmuted.
/// - `communityName`: The name of the community where the action is performed.
/// - `type`: The type of action to be performed, either "mute" or "unmute".
/// - `note`: Optional moderator note explaining the reason for the action.
/// - `post`: A boolean indicating whether the action is performed on a post.
///
/// Upon completion of the request, this function displays a snackbar with an appropriate
/// message based on the response status code. Possible status codes and their corresponding
/// messages are as follows:
///
/// - 200: User muted or unmuted successfully.
/// - 400: Invalid data provided.
/// - 401: Unauthorized access.
/// - 402: The user is not a moderator.
/// - 404: Community or user not found.
/// - 406: The moderator doesn't have permission to perform the action.
/// - 500: Internal server error.
/// - Default: An unknown error occurred.
///
/// Example usage:
///
/// ```dart
/// muteUser(
///   context,
///   'username',
///   'communityName',
///   'mute',
///   'Optional moderator note',
///   true,
/// );
/// ```
/// 
void muteUser(BuildContext context, String username, String communityName,
    String type, String note, bool post) async {
  print('community name $communityName');
  username = username.replaceFirst('u/', '');
  int statusCode =
      await muteOrUnmuteUser(communityName, username, type, note, post);

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
    case 406:
      showSnackbar(context, "Moderator doesn't have permission");
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
