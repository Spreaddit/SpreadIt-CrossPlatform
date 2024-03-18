import 'package:flutter/material.dart';

class SettingsSectionBody extends StatelessWidget {
  const SettingsSectionBody({Key? key, required this.sectionChildren})
      : super(key: key);

  final List<Widget> sectionChildren;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sectionChildren),
    );
  }
}
