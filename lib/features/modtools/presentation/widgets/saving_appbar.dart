import 'package:flutter/material.dart';

class SavingAppBar extends StatefulWidget implements PreferredSizeWidget {
  SavingAppBar({Key? key, required this.title, required this.onSavePressed})
      : super(key: key);

  final String title;
  final VoidCallback? onSavePressed;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  State<SavingAppBar> createState() => _SavingAppBarState();
}

class _SavingAppBarState extends State<SavingAppBar> {
  void showDiscardDialog() {
    if (widget.onSavePressed == null) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Discard changes?"),
            content: Text("Are you sure you want to discard changes?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Discard"),
              ),
            ],
          );
        },
      );
    }
  }

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
          Icons.arrow_back,
        ),
        onPressed: (() {
          showDiscardDialog();
        }),
      ),
      actions: [
        TextButton(
          onPressed: widget.onSavePressed,
          child: Text(
            'Save',
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
