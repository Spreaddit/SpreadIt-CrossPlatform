import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/data/mute_or_unmute_community.dart';

/// Mutes or unmutes a community.
///
/// This function sends a request to the backend API to mute or unmute a community
/// based on the provided parameters. It takes the following parameters:
///
/// - `context`: The build context used for showing snackbar notifications.
/// - `communityName`: The name of the community to be muted or unmuted.
/// - `type`: The type of action to be performed, either "mute" or "unmute".
///
/// Upon completion of the request, this function displays a snackbar with an appropriate
/// message based on the response status code. Possible status codes and their corresponding
/// messages are as follows:
///
/// - 200: Community muted or unmuted successfully.
/// - 400: Missing or invalid parameters provided.
/// - 401: Authorization token is required.
/// - 402: The community is already muted or unmuted.
/// - 404: Community not found.
/// - 500: An unexpected error occurred on the server.
/// - Default: An unknown error occurred.
///
/// Example usage:
///
/// ```dart
/// mutecommunity(
///   context,
///   'communityName',
///   'mute',
/// );
/// ```
/// 
void mutecommunity(BuildContext context, String communityName,
    String type) async {
  print('community name $communityName');
  int statusCode = await muteOrUnmuteCommunity(communityName, type);
  switch (statusCode) {
    case 200:
      showSnackbar(context, "Community ${type}d successfully");
      break;
    case 400:
      showSnackbar(context, "Missing or invalid parameters");
      break;
    case 401:
      showSnackbar(context, "Authorization token is required");
      break;
    case 402:
      showSnackbar(context, "Community is already muted");
      break;
    case 404:
      showSnackbar(context, "Community not found");
      break;
    case 500:
      showSnackbar(context, "An error occured please try again later");
      break;
    default:
      showSnackbar(context, "An error occured please try again later");
  }
}

void showSnackbar(BuildContext context, String message) {
  CustomSnackbar(content: message).show(context);
}
