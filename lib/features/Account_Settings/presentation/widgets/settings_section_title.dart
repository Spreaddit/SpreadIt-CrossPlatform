import 'package:flutter/material.dart';

/// A widget that represents a template for the title of settings section.
class SettingsSectionTitle extends StatelessWidget {
  /// Creates a settings section title.
  ///
  /// The [title] parameter is [required] and represents the text of the title.
  ///
  /// The [textColor] parameter sets the color of the title text. It defaults to
  /// [Color.fromARGB(184, 54, 54, 54)].
  const SettingsSectionTitle({
    Key? key,
    required this.title,
    this.textColor = const Color.fromARGB(184, 54, 54, 54),
  }) : super(key: key);

  /// The text of the title.
  final String title;

  /// The color of the title text.
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
        ),
      ),
    );
  }
}
