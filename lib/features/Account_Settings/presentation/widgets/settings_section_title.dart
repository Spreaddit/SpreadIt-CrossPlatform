import 'package:flutter/material.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({
    Key? key,
    required this.title,
    this.textColor = const Color.fromARGB(184, 54, 54, 54),
  }) : super(key: key);

  final String title;
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
              fontSize: 12.5),
        ),
      ),
    );
  }
}
