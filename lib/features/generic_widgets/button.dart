import 'package:flutter/material.dart';

/// A customizable button widget.
/// This widget allows you to create a button with various customization options such as text, background color,
/// foreground color, prefix icon, and image.   
/// To use this widget, provide the required parameters:    
/// -onPressed: Callback function to be executed when the button is pressed.   
/// -text: Text to be displayed on the button.   
/// -backgroundColor: Background color of the button.  
/// -foregroundColor: Foreground color of the button (text color).   
/// Additionally, you can optionally provide:    
/// -prefixIcon: An optional icon to be displayed before the text.   
/// -imagePath: An optional path to an image asset to be displayed before the text.   
/// ```dart
/// Button(
///   onPressed: () {
///     // Handle button press
///   },
///   text: 'Submit',
///   backgroundColor: Colors.blue,
///   foregroundColor: Colors.white,
///   prefixIcon: Icons.send,
/// )
/// ```

class Button extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? prefixIcon;
  final String? imagePath;

  const Button({
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    this.prefixIcon,
    this.imagePath,
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.bottomCenter,
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
            if (widget.prefixIcon != null)
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(widget.prefixIcon),
              ),
            if (widget.imagePath != null)
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Image.asset(
                  widget.imagePath!,
                  width: 24,
                  height: 24,
                ),
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
