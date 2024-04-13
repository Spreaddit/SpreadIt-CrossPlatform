import 'package:flutter/material.dart';

/// The `SocialMediaButton` widget represents a button for social media platforms.
class SocialMediaButton extends StatelessWidget {
  /// The icon to display on the button.
  final IconData icon;

  /// The text label for the button.
  final String text;

  /// The color of the icon.
  final Color iconColor;

  /// The background color of the button.
  final Color backgroundColor;

  /// A flag indicating whether the clear button is enabled.
  final bool enableClear;

  /// A callback function triggered when the button is pressed.
  final VoidCallback? handleSelection;

  /// A callback function triggered when the clear button is pressed.
  final VoidCallback? onClearPressed;

  /// Creates a `SocialMediaButton` widget.
  ///
  /// The `icon`, `text`, and `iconColor` parameters are required.
  /// The `backgroundColor` parameter is optional and defaults to `Color(0xFFFBFBFB)`.
  /// The `enableClear`, `handleSelection`, and `onClearPressed` parameters are optional.
  const SocialMediaButton({
    required this.icon,
    required this.text,
    required this.iconColor,
    this.backgroundColor = const Color(0xFFFBFBFB),
    this.enableClear = false,
    this.handleSelection,
    this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: handleSelection ?? () {},
      icon: Icon(icon, color: iconColor),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (enableClear)
            SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                onPressed: onClearPressed,
                icon: Icon(Icons.clear, size: 18),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10.0),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
      ),
    );
  }
}
