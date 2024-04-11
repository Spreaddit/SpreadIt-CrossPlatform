import 'package:flutter/material.dart';

class SmallButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double width;
  final double height;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const SmallButton({
    required this.buttonText,
    required this.onPressed,
    required this.isEnabled,
    required this.width,
    required this.height,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: widget.isEnabled ? widget.onPressed : null,
          child: Text(widget.buttonText),
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor != null
                  ? widget.backgroundColor
                  : Colors.blue[900],
              foregroundColor: widget.foregroundColor != null
                  ? widget.foregroundColor
                  : Colors.white,
              fixedSize: Size(widget.width, widget.height),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
    );
  }
}
