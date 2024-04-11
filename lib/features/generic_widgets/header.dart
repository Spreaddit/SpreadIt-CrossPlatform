import 'package:flutter/material.dart';

/// A header widget for displaying the logo and a title with optional back and action buttons.
/// This widget consists of a row containing a back button, the app logo, a title, and an optional action button.   
/// Required parameters:   
/// -title: The title displayed in the header.   
/// Optional parameters:   
/// -buttonText: Text displayed on the action button. Defaults to an empty string.   
/// -onPressed: Callback function triggered when the action button is pressed.   
/// ```dart
/// Header(
///   title: 'Page Title',
///   buttonText: 'Action',
///   onPressed: () {
///     // Handle action button press
///   },
/// )
/// ```
class Header extends StatelessWidget {
  final String buttonText;
  final String title;
  final VoidCallback? onPressed;

  Header({
    this.buttonText = "",
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/LogoSpreadIt.png',
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.grey, // Text color
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 20),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
