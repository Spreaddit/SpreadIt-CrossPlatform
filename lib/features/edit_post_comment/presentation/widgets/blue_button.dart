import 'package:flutter/material.dart';

class BlueButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const BlueButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<BlueButton> createState() => _BlueButtonState();
}

class _BlueButtonState extends State<BlueButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Text(widget.buttonText),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              fixedSize: Size(80, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
    );
  }
}
