import 'package:flutter/material.dart';

class TermsAndCondText extends StatelessWidget {
  const TermsAndCondText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'By continuing, you agree to our ',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF95A5A6),
        ),
        children: [
          TextSpan(
            text: 'User Agreement ',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFF4500),
            ),
          ),
          TextSpan(
            text: 'and acknowledge that you understand the ',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF95A5A6),
            ),
          ),
          TextSpan(
            text: 'Privacy Policy.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFF4500),
            ),
          ),
        ],
      ),
    );
  }
}
