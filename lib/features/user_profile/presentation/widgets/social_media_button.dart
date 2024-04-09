import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color backgroundColor; 
  final bool enableClear;
  final VoidCallback? handleSelection;
  final VoidCallback? onClearPressed;

  const SocialMediaButton({
    required this.icon,
    required this.text,
    required this.iconColor,
    this.backgroundColor = const Color(0xFFFBFBFB), 
    this.enableClear = false,
    this.handleSelection,
    this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: handleSelection ?? () {},
      icon: Icon(icon, color: iconColor),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (enableClear)
            SizedBox(
              width: 24, 
              height: 24, 
              child: IconButton(
                onPressed: onClearPressed,
                icon: Icon(Icons.clear, size: 18),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10.0),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
      ),
    );
  }
}
