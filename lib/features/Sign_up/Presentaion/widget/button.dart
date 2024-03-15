import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? prefixIcon; // Optional prefix icon

  const Button({
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    this.prefixIcon, // Optional prefix icon
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) // If prefix icon is passed, show it
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(widget.prefixIcon),
              ),
            Expanded(
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
