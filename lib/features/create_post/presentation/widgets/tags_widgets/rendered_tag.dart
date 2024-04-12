import 'package:flutter/material.dart';

class RenderedTag extends StatelessWidget {

  final IconData icon;
  final String text;

  const RenderedTag({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 150,
      margin:EdgeInsets.fromLTRB(15, 0, 15, 5),
        child:Row(
          children: [
            Icon(icon),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
         ],
      ),
    );
  }
}