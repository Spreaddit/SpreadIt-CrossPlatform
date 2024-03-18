import 'package:flutter/material.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

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
              color: Color.fromARGB(184, 54, 54, 54),
              fontWeight: FontWeight.w700,
              fontSize: 12.5),
        ),
      ),
    );
  }
}
