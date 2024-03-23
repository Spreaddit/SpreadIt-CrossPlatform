import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String buttonText;
  final String title;
  final VoidCallback onPressed;

  Header({
    required this.buttonText,
    required this.title,
    required this.onPressed,
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