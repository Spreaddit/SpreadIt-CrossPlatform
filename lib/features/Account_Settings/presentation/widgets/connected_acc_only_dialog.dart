import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/add_password_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';

class ConnectedAccountOnlyDialog {
  ConnectedAccountOnlyDialog(
      this.buildContext, this.callOption, this.userEmail) {
    showConnectedAccDialog(buildContext, callOption);
  }

  BuildContext buildContext;
  int callOption;
  String userEmail;

  final List<String> titles = [
    "Update email address",
    "Check your email",
    "Disconnect from Google",
  ];

  final List<String> texts = [
    "To change your email address, you need to create a Reddit password first.",
    "Check your email for a link to create a password.",
    "To disconnect your Google account, you need to create a Reddit password first.",
  ];

  void showConnectedAccDialog(BuildContext context, int callOption) {
    if (callOption == 1) {
      sendAddPasswordEmail(context);
    } else if (callOption >= titles.length || callOption < 0) {
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Center(
            child: Text(
              titles[callOption],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(20),
          children: <Widget>[
            Center(
              child: Text(
                texts[callOption],
                softWrap: true,
                textAlign: TextAlign.center,
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
                      sendAddPasswordEmail(context);
                    },
                    text: 'Ok',
                    backgroundColor: Colors.blueAccent,
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

  /// Handles the process of sending the email with the [AddPasswordPage] link.
  /// For now though, it routes to [AddPasswordPage] that is until coordination
  /// between BE and CP on how to handle the email occurs.
  void sendAddPasswordEmail(BuildContext context) {
    showDialog(
      context: (context),
      builder: (context) => SimpleDialog(
        title: callOption != 1
            ? Center(
                child: Text(
                  "Check your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange
                      .withOpacity(0.25), // Semi-opaque orange background
                  shape: BoxShape.circle, // Circular border
                ),
                child: Center(
                  child: Icon(
                    Icons.email,
                    size: 20,
                    color: Colors.orange, // Orange color for the icon
                  ),
                ),
              ),
        contentPadding: EdgeInsets.all(20),
        children: <Widget>[
          Center(
            child: Text(
              "We sent an email to $userEmail with a link to create your password.",
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Button(
                  onPressed: () {
                    // Should be:
                    Navigator.of(context).pop();
                    // Dont pop twice if we are here from pressing Add password
                    if (callOption != 1) {
                      Navigator.of(context).pop();
                    }
                    // Currently we add:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddPasswordPage(),
                      ),
                    );
                  },
                  text: 'Ok',
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
