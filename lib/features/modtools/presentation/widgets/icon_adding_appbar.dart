import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_approved_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_edit_banned_page.dart';

class IconAddingAppBar extends StatefulWidget implements PreferredSizeWidget {
  IconAddingAppBar({
    Key? key,
    required this.title,
    required this.communityName,
    required this.isApproving,
    required this.onRequestCompleted,
  }) : super(key: key);

  final String title;
  final String communityName;

  /// Callback function to be called when the request is completed
  final Function onRequestCompleted;

  /// true if approving, false if banning
  final bool isApproving;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  State<IconAddingAppBar> createState() => _IconAddingAppBarState();
}

class _IconAddingAppBarState extends State<IconAddingAppBar> {
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
          Navigator.pop(context);
        }),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add_outlined),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => widget.isApproving
                  ? AddApprovedPage(
                      communityName: widget.communityName,
                      onRequestCompleted: widget.onRequestCompleted,
                    )
                  : AddOrEditBannedPage(
                      communityName: widget.communityName,
                      isAdding: true,
                      onRequestCompleted: widget.onRequestCompleted,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
