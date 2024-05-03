import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NonSkippableAlertDialog extends StatelessWidget {
  final String title;
  final String? content;
  final VoidCallback onPressed;

  NonSkippableAlertDialog(
      {required this.title, this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.deepOrangeAccent,
          size: 50,
        ),
        title: Text(
          title,
          softWrap: true,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: (content == null)
            ? null
            : Text(
                content ?? "",
                softWrap: true,
                style: TextStyle(fontSize: 16),
              ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrangeAccent,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
              child: Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
