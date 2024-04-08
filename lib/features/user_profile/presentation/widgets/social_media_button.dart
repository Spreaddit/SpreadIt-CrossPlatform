import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final bool enableClear;
  final VoidCallback? handleSelection;
  final VoidCallback? onClearPressed;

  const SocialMediaButton({
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.enableClear = false,
    this.handleSelection,
    this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: handleSelection ?? () {},
      icon: Icon(icon, color: backgroundColor),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (enableClear)
            SizedBox(
              width: 24, // Adjust this width as needed
              height: 24, // Adjust this height as needed
              child: IconButton(
                onPressed: onClearPressed,
                icon: Icon(Icons.clear, size: 18), // Adjust the size here
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10.0),
        backgroundColor: Color.fromARGB(255, 251, 251, 251),
        foregroundColor: Colors.black,
      ),
    );
  }
}
