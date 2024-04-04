import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback? handleSelection;

  const SocialMediaButton({
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.handleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: handleSelection ?? () {},
      icon: Icon(icon, color: backgroundColor),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10.0),
        backgroundColor: Color.fromARGB(255, 251, 251, 251),
        foregroundColor: Colors.black,
      ),
    );
  }
}
