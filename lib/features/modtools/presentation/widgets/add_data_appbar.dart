import 'package:flutter/material.dart';

/// Custom app bar widget for adding or saving data.
class AddOrSaveDataAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Title of the app bar.
  final String title;

  /// Callback function when the button is pressed.
  final VoidCallback? onButtonPressed;

  /// Text to be displayed on the action button.
  final String actionText;

  /// Constructor for [AddOrSaveDataAppBar].
  const AddOrSaveDataAppBar({
    Key? key,
    required this.title,
    required this.onButtonPressed,
    required this.actionText,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  State<AddOrSaveDataAppBar> createState() => _AddOrSaveDataAppBarState();
}

class _AddOrSaveDataAppBarState extends State<AddOrSaveDataAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Color.fromARGB(255, 229, 223, 223),
      elevation: 4.0,
      title: Text(
        widget.title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          Icons.close_outlined,
        ),
        onPressed: (() {
          Navigator.pop(context);
        }),
      ),
      actions: [
        TextButton(
          onPressed: widget.onButtonPressed,
          child: Text(
            widget.actionText,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
