import 'package:flutter/material.dart';

class AddingDataAppBar extends StatefulWidget implements PreferredSizeWidget {
  AddingDataAppBar({Key? key, required this.title, required this.onSavePressed})
      : super(key: key);

  final String title;
  final VoidCallback? onSavePressed;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  State<AddingDataAppBar> createState() => _AddingDataAppBarState();
}

class _AddingDataAppBarState extends State<AddingDataAppBar> {
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
          onPressed: widget.onSavePressed,
          child: Text(
            'Add',
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
