import 'package:flutter/material.dart';

/// A widget that represents a template for the body of a settings section.
class SettingsSectionBody extends StatelessWidget {
  /// Creates a settings section body.
  ///
  /// The [sectionChildren] parameter is [required] and represents the children widgets
  /// to be displayed in the section body.
  const SettingsSectionBody({Key? key, required this.sectionChildren})
      : super(key: key);

  /// The children widgets to be displayed in the section body.
  final List<Widget> sectionChildren;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sectionChildren,
      ),
    );
  }
}
