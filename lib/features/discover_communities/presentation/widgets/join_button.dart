import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_subscription_info.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/features/user.dart';

/// `JoinButton` is a StatefulWidget that represents a button for joining a community.
///
/// This widget is stateful, meaning that it can change over time. The state for this widget is defined in `_JoinButtonState`.
class JoinButton extends StatefulWidget {
  final String communityName;

  JoinButton({required this.communityName});

  @override
  _JoinButtonState createState() => _JoinButtonState();
}

/// `_JoinButtonState` is a class that contains the state for a `JoinButton`.
///
/// It has two boolean properties: `isJoined` and `isLoading`. `isJoined` indicates whether the user has joined the community, and `isLoading` indicates whether the widget is currently performing a load operation.
///
/// The `initState` method is overridden to call `setupInitialJoinState` when the widget is first created. This method is responsible for setting up the initial state of the `isJoined` property.
///
/// The `setupInitialJoinState` method is an async function that retrieves the subscription data for the community and updates `isJoined` accordingly. If the subscription data indicates that the user is subscribed to the community, `isJoined` is set to true. If the subscription data cannot be retrieved, an error message is printed.
class _JoinButtonState extends State<JoinButton> {
  bool isJoined = false;
  bool isLoading = false;
  bool isNotApprovedForJoin = false;

  @override
  void initState() {
    super.initState();
    setupInitialJoinState();
    checkIfCanJoin();
  }

  /// [checkIfCanJoin] : a function used to check if users aren't approved for joining the community

  void checkIfCanJoin() async {
    await checkIfBannedOrPrivate(
            widget.communityName, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForJoin = value;
    });
    if (mounted) {
      setState(() {
        //TODO: check if this causes exception
        isNotApprovedForJoin = isNotApprovedForJoin;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setupInitialJoinState() async {
    var subscriptionData = await getCommunitySubStatus(widget.communityName);
    if (subscriptionData["isSubscribed"] == -1) {
      print("Failed to retrieve subscription data");
    } else {
      if (mounted) {
        setState(() {
          isJoined = subscriptionData["isSubscribed"];
        });
      }
    }
  }

  void toggleJoin() async {
    if (isNotApprovedForJoin && !isJoined) {
      CustomSnackbar(content: "You are not approved to join this community")
          .show(context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      if (isJoined) {
        // Unjoin the community
        String? accessToken = UserSingleton().getAccessToken();
        var postRequestInfo = {
          "communityName": widget.communityName,
          "token": accessToken
        };
        var response =
            await postUnsubscribeRequest(postRequestInfo: postRequestInfo);
        if (response == 200) {
          setState(() {
            isJoined = false;
          });
        } else {
          print(response);
        }
      } else {
        User? currentUser = UserSingleton().getUser();
        String? userId = currentUser?.id;
        var postRequestInfo = {"name": widget.communityName, "userId": userId};
        var response =
            await postSubscribeRequest(postRequestInfo: postRequestInfo);
        if (response == 200) {
          setState(() {
            isJoined = true;
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: toggleJoin,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isJoined ? Colors.white : const Color.fromRGBO(0, 69, 172, 1.0),
        foregroundColor:
            isJoined ? const Color.fromRGBO(0, 69, 172, 1.0) : Colors.white,
        side:
            BorderSide(color: const Color.fromRGBO(0, 69, 172, 1.0), width: 2),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.blue,
            )
          : Text(isJoined ? 'Joined' : 'Join'),
    );
  }
}
