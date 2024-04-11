import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/blue_button.dart';
import '../../../generic_widgets/small_custom_button.dart';

class GenericHeader extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isEnabled;
  final VoidCallback onIconPress;
  final bool showHeaderTitle;

  const GenericHeader({
    required this.buttonText,
    required this.onPressed,
    required this.isEnabled,
    required this.onIconPress,
    required this.showHeaderTitle,
  });

  @override
  State<GenericHeader> createState() => _GenericHeaderState();
}

class _GenericHeaderState extends State<GenericHeader> {
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
            icon: Icon(Icons.clear_rounded, size: 40),
            onPressed: widget.onIconPress,
          ),
        ),
        if (widget.showHeaderTitle)
          Center(
              child: Text("Edit",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))),
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
