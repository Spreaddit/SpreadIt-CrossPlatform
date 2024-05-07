import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_approved_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_edit_banned_page.dart';

/// Represents an app bar with an icon for adding approved users or banned users.
///
/// This app bar contains a title, back button, and an add icon button for adding either approved or banned users,
/// based on the value of [isApproving].
///
/// Required parameters:
/// - [title] : The title of the app bar.
/// - [communityName] : The name of the community.
/// - [onRequestCompleted] : Callback function invoked when the request is completed.
/// - [isApproving] : A boolean value indicating whether the action is approving (true) or banning (false).
class IconAddingAppBar extends StatefulWidget implements PreferredSizeWidget {
  const IconAddingAppBar({
    Key? key,
    required this.title,
    required this.communityName,
    required this.isApproving,
    required this.onRequestCompleted,
  }) : super(key: key);

  final String title;
  final String communityName;
  final Function onRequestCompleted;
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
