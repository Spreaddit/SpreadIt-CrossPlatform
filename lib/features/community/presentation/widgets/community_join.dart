import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';

class JoinCommunityBtn extends StatefulWidget {
  JoinCommunityBtn({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<JoinCommunityBtn> createState() => _JoinCommunityBtnState();
}

class _JoinCommunityBtnState extends State<JoinCommunityBtn> {
  late Map<String, dynamic> subscriptionData;
  bool isJoined = Random().nextBool();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {}

  void handleBtnPress() {
    if (!isJoined) {
      setState(() {
        isJoined = true;
      });
      CustomSnackbar(content: "Successfully Joined").show(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Are you sure you want to leave the r/${widget.communityName} community",
                softWrap: true,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                    onPressed: () => Navigator.pop(context),
                    text: 'Cancel',
                    backgroundColor: const Color.fromARGB(255, 214, 214, 215),
                    foregroundColor: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Button(
                    onPressed: () {
                      unsubscribe();
                    },
                    text: 'Leave',
                    backgroundColor: const Color.fromARGB(255, 255, 85, 0),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  void unsubscribe()
  {
    setState(() {
      isJoined = false;
    });
    Navigator.of(context).pop();
    CustomSnackbar(content: "Successfully Left").show(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        handleBtnPress();
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: isJoined
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.blueAccent),
      ),
      child: Text(
        isJoined ? 'Joined' : 'Join',
        style: isJoined
            ? TextStyle(color: Colors.black)
            : TextStyle(color: Colors.white),
      ),
    );
  }
}
