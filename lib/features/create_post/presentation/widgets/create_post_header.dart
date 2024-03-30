import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../generic_widgets/button.dart';
import './blue_button.dart';

class CreatePostHeader extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;
  
  const CreatePostHeader({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            icon: Icon(
              Icons.clear_rounded,
              size: 40),
            onPressed: () {},
          ),
        ),
      BlueButton(buttonText: buttonText, onPressed: onPressed),
      ],
    );
  }
}