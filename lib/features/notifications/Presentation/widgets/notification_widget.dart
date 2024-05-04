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
  final void Function(String) disable;

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
    required this.disable,
    this.buttonText,
    this.buttonIcon,
    this.isRead = false,
    this.followed = false,
    this.community = false,
    Community? recommendedCommunity,
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

  void markmessageasRead() {
    if (widget.notification!.isRead == false) {
      MarkAsRead(id: widget.notification!.id!, type: 'one');
      setState(() {
        isRead = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isRead = widget.isRead;
  }

  @override
  void didUpdateWidget(covariant NotificationWidget oldWidget) {
    setState(() {
      isRead = widget.isRead;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        markmessageasRead();
        widget.onPressed?.call();
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        tileColor: isRead ? null : Colors.lightBlueAccent.withOpacity(0.1),
        leading: SizedBox(
          width: 40.0,
          height: 40.0,
          child: Stack(
            children: [
              if (widget.notification!.communitypic != null ||
                  widget.notification!.relatedUser != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.community
                        ? widget.notification!.communitypic!
                        : widget.notification!.relatedUser!.avatarUrl!,
                  ),
                  radius: 20.0,
                ),
              if (widget.notification!.communitypic == null &&
                  widget.notification!.relatedUser == null)
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/LogoSpreadIt.png'),
                  radius: 20.0,
                ),
              if (widget.iconData != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(
                      widget.iconData,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 15,
                    ),
                  ),
                ),
            ],
          ),
        ),
        title: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.notification!.notificationType == 'Account Update'
                  ? Text('You have been banned from Spreddit')
                  : widget.community
                      ? Text(widget.content)
                      : Text("${widget.notification!.content} ${widget.date}"),
              SizedBox(height: 4),
            ],
          ),
        ),
        subtitle: (widget.buttonText != null && widget.buttonIcon != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        markmessageasRead();
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : (!widget.community)
                ? Text(widget.content)
                : null,
        trailing: GestureDetector(
          onTap: () async {
            markmessageasRead();
            showModalBottomSheet(
              context: context,
              builder: (context) => ManageNotificationBottomSheet(
                community: widget.community,
                onHide: widget.onHide,
                notification: widget.notification!,
                disable: widget.disable,
              ),
            );
          },
          child: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
