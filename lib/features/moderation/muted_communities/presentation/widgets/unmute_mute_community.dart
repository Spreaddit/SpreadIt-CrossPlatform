import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/data/mute_or_unmute_community.dart';

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
      showSnackbar(context, "An unexpected error occurred on the server");
      break;
    default:
      showSnackbar(context, "Unknown error occurred");
  }
}

void showSnackbar(BuildContext context, String message) {
  CustomSnackbar(content: message).show(context);
}
