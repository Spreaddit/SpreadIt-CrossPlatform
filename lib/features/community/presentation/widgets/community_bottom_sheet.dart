import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_subscription_info.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/data/mute_or_unmute_community.dart';

/// A bottom sheet widget for interacting with a community.
class CommunityBottomSheet extends StatelessWidget {
  final String communityName;
  final Function onStateChange;
  bool joined;
  bool muted;

  /// Constructs a [CommunityBottomSheet].
  ///
  /// The [communityName] is the name of the community.
  /// The [joined] flag indicates whether the user is a member of the community.
  /// The [muted] flag indicates whether the community is muted.
  /// The [onStateChange] is a callback function that is called when the state of the community changes.
  CommunityBottomSheet({
    required this.communityName,
    required this.joined,
    required this.onStateChange,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      icons: [
        Icons.speaker_notes_off,
        joined ? Icons.remove : Icons.add,
      ],
      text: [
        muted ? "Unmute r/$communityName" : "Mute r/$communityName",
        joined ? "Leave r/$communityName" : "Join",
      ],
      onPressedList: [
        () {
          mute(communityName, muted, context);
        },
        () {
          joinOrLeave(context);
        },
      ],
    );
  }


  /// Mutes or unmutes the community based on the [muted] flag.
  ///
  /// If the community is muted, it will be unmuted. If it is not muted, it will be muted.
  /// Displays a snackbar to indicate success or failure.
  void mute(String communityName, bool muted, BuildContext context) async {
    if (muted) {
      int response = await muteOrUnmuteCommunity(communityName, 'unmute');
      if (response == 200) {
        CustomSnackbar(content: "Community Unmuted successfully").show(context);
      } else {
        CustomSnackbar(content: "An error occurred, please try again later").show(context);
      }
    } else {
      int response = await muteOrUnmuteCommunity(communityName, 'mute');
      if (response == 200) {
        CustomSnackbar(content: "Community muted successfully").show(context);
      } else {
        CustomSnackbar(content: "An error occurred, please try again later").show(context);
      }
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  /// Joins or leaves the community.
  void joinOrLeave(BuildContext context) async{
    if (!joined) {
      var response = await postSubscribeRequest(postRequestInfo: {'name': communityName});
      if (response == 200) {
        CustomSnackbar(content: "Community joined successfully").show(context);
        onStateChange();
      } else {
        CustomSnackbar(content: "An error occurred, please try again later").show(context);
      }
    } else {
      var response = await postUnsubscribeRequest(postRequestInfo: {'communityName': communityName});
      if (response == 200) {
        CustomSnackbar(content: "Community unjoined successfully").show(context);
        onStateChange();
      } else {
        CustomSnackbar(content: "An error occurred, please try again later").show(context);
      }
    }
    Navigator.pop(context); // Close the bottom sheet
  }
}
