import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_subscription_info.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/features/user.dart';

class JoinButton extends StatefulWidget {
  final String communityName;

  JoinButton({required this.communityName});

  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool isJoined = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setupInitialJoinState();
  }

  void setupInitialJoinState() async {
    var subscriptionData = await getCommunitySubStatus(widget.communityName);
    if (subscriptionData["isSubscribed"] == -1) {
      print("Failed to retrieve subscription data");
    } else {
      setState(() {
        isJoined = subscriptionData["isSubscribed"];
      });
    }
  }

  void toggleJoin() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));

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
        setState(() {
          isLoading = false;
        });
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
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
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
