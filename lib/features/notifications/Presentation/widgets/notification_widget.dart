import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/mark_as_read.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/navigation_buttom_sheet.dart';

/// A widget for displaying a single notification item.
class NotificationWidget extends StatefulWidget {
  /// The notification object to display.
  final Notifications? notification;

  /// The content of the notification.
  final String content;

  /// The icon data to display with the notification.
  final IconData? iconData;

  /// Callback function to be executed when the notification is pressed.
  final VoidCallback? onPressed;

  /// Callback function to hide the notification.
  final void Function(String, Notifications) onHide;

  /// Callback function to disable the notification.
  final void Function(String) disable;

  /// The text to display on the button (if any).
  final String? buttonText;

  /// The icon data to display on the button (if any).
  final IconData? buttonIcon;

  /// The date of the notification.
  final String date;

  /// Flag indicating whether the notification is read.
  final bool isRead;

  /// Flag indicating whether the user is followed.
  final bool followed;

  /// Flag indicating whether the notification is related to a community.
  final bool community;

  /// Constructs a [NotificationWidget].
  ///
  /// [notification] is the notification object to display.
  /// [content] is the content of the notification.
  /// [date] is the date of the notification.
  /// [iconData] is the icon data to display with the notification.
  /// [onPressed] is the callback function when the notification is pressed.
  /// [onHide] is the callback function to hide the notification.
  /// [disable] is the callback function to disable the notification.
  /// [buttonText] is the text to display on the button.
  /// [buttonIcon] is the icon data to display on the button.
  /// [isRead] indicates whether the notification is read.
  /// [followed] indicates whether the user is followed.
  /// [community] indicates whether the notification is related to a community.
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
      markAsRead(id: widget.notification!.id!, type: 'one');
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
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            widget.notification!.notificationType == 'Account Update'
                ? Text('You have been banned from Spreddit')
                : widget.community
                    ? Text(widget.content)
                    : Text("${widget.notification!.content} ${widget.date}"),
            SizedBox(height: 4),
          ],
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

/// Example usage:
///
/// ```dart
/// NotificationWidget(
///   notification: notification,
///   content: 'New comment on your post',
///   date: '2024-05-06',
///   iconData: Icons.comment,
///   onPressed: () {
///     // Handle notification pressed event
///   },
///   onHide: (id, notification) {
///     // Handle hiding the notification
///   },
///   disable: (type) {
///     // Handle disabling the notification
///   },
///   buttonText: 'View',
///   buttonIcon: Icons.visibility,
///   isRead: false,
///   followed: true,
///   community: false,
/// )
/// ```