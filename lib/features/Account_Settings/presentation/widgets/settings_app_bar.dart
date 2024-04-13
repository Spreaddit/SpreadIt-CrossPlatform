import 'package:flutter/material.dart';

/// A custom app bar designed for the settings screen.
class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a custom app bar with a title to be used in the Settings page and sub-pages.
  ///
  /// Parameters:
  /// - [title] : [String] The title of the app bar [required].
  const SettingsAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Color.fromARGB(255, 229, 223, 223),
      elevation: 4.0,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: (() {
          Navigator.pop(context);
        }),
      ),
    );
  }
}
