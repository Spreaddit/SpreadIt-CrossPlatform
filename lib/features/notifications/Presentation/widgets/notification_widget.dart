import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/mark_as_read.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/navigation_buttom_sheet.dart';

class NotificationWidget extends StatefulWidget {
  final Notifications? notification;
  final String content;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final void Function(String, Notifications) onHide;
  final String? buttonText;
  final IconData? buttonIcon;
  final String date;
  final bool isRead;
  final bool followed;
  final bool community;

  const NotificationWidget({
    Key? key,
    this.notification,
    required this.content,
    required this.date,
    this.iconData,
    this.onPressed,
    required this.onHide,
    this.buttonText,
    this.buttonIcon,
    this.isRead = false,
    this.followed = false,
    this.community = false, Community? recommendedCommunity,
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

  Future<void> markmessageasRead() async{
    await MarkAsRead(id: widget.notification!.id!, type: 'one');
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
                  backgroundImage:
                      NetworkImage( widget.community ? widget.notification!.communitypic! :widget.notification!.relatedUser!.avatarUrl!),
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
                widget.community ? Text(widget.content) : Text("${widget.notification!.content} ${widget.date}"),
                SizedBox(height: 4), // Add some space between title and content
                if (!widget.community) Text(widget.content),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              markmessageasRead();
              showModalBottomSheet(
                context: context,
                builder: (context) => ManageNotificationBottomSheet(
                  followed: widget.followed,
                  community: widget.community,
                  onHide: widget.onHide,
                  notification: widget.notification!,
                ),
              );
            },
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      subtitle: Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.buttonText != null && widget.buttonIcon != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async{
                    await markmessageasRead();
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
