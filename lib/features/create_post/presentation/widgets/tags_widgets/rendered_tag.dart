import 'package:flutter/material.dart';

/// [RenderedTag] a template of how each tag will look on the create post page when its flag is set

class RenderedTag extends StatelessWidget {

  final IconData icon;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? iconSize;

  const RenderedTag({
    required this.icon,
    required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? 25 : height,
      width: width == null ? 150 : width,
      margin:EdgeInsets.fromLTRB(15, 0, 15, 5),
        child:Row(
          children: [
            Icon(
              icon,
              size: iconSize == null ? 24 : iconSize ,),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize == null ? 20 : fontSize,
              ),
            ),
         ],
      ),
    );
  }
}