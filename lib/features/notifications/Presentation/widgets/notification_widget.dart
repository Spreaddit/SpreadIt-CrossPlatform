import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/navigation_buttom_sheet.dart';

class NotificationWidget extends StatefulWidget {
  final String title;
  final String content;
  final String profilePicUrl;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final VoidCallback? onMoreVertPressed;
  final String? buttonText;
  final IconData? buttonIcon;
  final String date;
  final bool isRead;
  final bool followed;
  final bool community;

  const NotificationWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.profilePicUrl,
    required this.date,
    this.iconData,
    this.onPressed,
    this.onMoreVertPressed,
    this.buttonText,
    this.buttonIcon,
    this.isRead = false,
    this.followed = false,
    this.community = false,
  }) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  var isRead;
  @override
  void initState() {
    super.initState();
    isRead = widget.isRead;
  }

  void MarkasRead() {
    //To_Do  Fetch mark as read
    setState(() {
      isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      tileColor: isRead ? null : Colors.lightBlueAccent.withOpacity(0.2),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.profilePicUrl),
                  radius: 20.0,
                ),
                if (widget.iconData != null)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: Icon(
                        widget.iconData,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 16), // Add some space between CircleAvatar and title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.title} ${widget.date}"),
                SizedBox(height: 4), // Add some space between title and content
                Text(widget.content),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              MarkasRead();
              showModalBottomSheet(
                context: context,
                builder: (context) => ManageNotificationBottomSheet(
                  followed: widget.followed,
                  community: widget.community,
                ),
              );
            },
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      subtitle: Container(
        margin: EdgeInsets.only(right: 20.0 , left :20.0 , top :10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.buttonText != null && widget.buttonIcon != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    MarkasRead();
                    widget.onPressed?.call();
                  },
                  icon: Icon(
                    widget.buttonIcon,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  label: Text(
                    widget.buttonText!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
