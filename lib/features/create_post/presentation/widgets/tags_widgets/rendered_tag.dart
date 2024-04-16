import 'package:flutter/material.dart';

/// [RenderedTag] a template of how each tag will look on the create post page when its flag is set

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