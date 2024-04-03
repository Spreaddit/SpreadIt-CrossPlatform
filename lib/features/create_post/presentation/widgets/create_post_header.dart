import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../generic_widgets/small_custom_button.dart';


class CreatePostHeader extends StatefulWidget {

  final String buttonText;
  final VoidCallback onPressed;
  final bool isEnabled;
  final VoidCallback onIconPress;
  
  const CreatePostHeader({
    required this.buttonText,
    required this.onPressed,
    required this.isEnabled,
    required this.onIconPress,
  });

  @override
  State<CreatePostHeader> createState() => _CreatePostHeaderState();
}

class _CreatePostHeaderState extends State<CreatePostHeader> {
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
            onPressed: widget.onIconPress,
          ),
        ),
      SmallButton(
        buttonText: widget.buttonText,
        onPressed: widget.onPressed,
        isEnabled: widget.isEnabled,
        width: 80,
        height: 20,
        ),
      ],
    );
  }
}