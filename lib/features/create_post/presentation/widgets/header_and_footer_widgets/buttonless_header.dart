import'package:flutter/material.dart';

/// [ButtonlessHeader] : a template for a header without a button
/// Parameters :
/// 1) [text] : the header text.
/// 2) [onIconPress] : the action to be taken when the cancel icon is pressed

class ButtonlesHeader extends StatefulWidget {

  final String text;
  final VoidCallback onIconPress;

  const ButtonlesHeader({
    required this.text,
    required this.onIconPress,
  });

  @override
  State<ButtonlesHeader> createState() => _ButtonlesHeaderState();
}

class _ButtonlesHeaderState extends State<ButtonlesHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 120, 10),
            height: 40,
            width: 40,
            child: IconButton(
              icon: Icon(
                Icons.clear_rounded,
                size: 40),
              onPressed: widget.onIconPress,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                ),
                ),
          ),
          Spacer(),  
        ],
      );
  }
}