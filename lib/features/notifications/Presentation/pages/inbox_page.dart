import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/pages/message_inbox.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/get_total_notifications.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/pages/notification_page.dart';
import '../../../generic_widgets/custom_bar.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/get_notifications.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/get_recommended_community.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
/// A StatefulWidget representing the inbox page.
class InboxPage extends StatefulWidget {
  /// Callback function to notify parent widget about the change in home sub-category.
  final void Function(int)? onChangeHomeSubCategory;

  /// Callback function to set a new message.
  final void Function(MessageModel message) setNewMessage;

  /// A model representing the new message.
  final MessageModel? newMessage;

  /// Flag indicating whether all notifications/messages are read.
  final bool isAllRead;

  /// Constructs an InboxPage instance.
  const InboxPage({
    Key? key,
    this.onChangeHomeSubCategory,
    required this.setNewMessage,
    required this.isAllRead,
    required this.newMessage,
  }) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

/// The state of the InboxPage widget.
class _InboxPageState extends State<InboxPage> {
  /// Index of the currently selected tab.
  int _selectedIndex = 0;
  List<Notifications> todayNotifications = [];
  List<Notifications> earlierNotifications = [];
  List<Notifications> notifications = [];
  bool isLoading = true;
  Notifications? recommendedCommunity;
  int unreadNotifications = -1;

  @override
  void initState() {
    super.initState();
    fetchData();
    unreadNotificationsCount();
  }

  /// Callback function to handle tab index change.
  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onChangeHomeSubCategory!(index + 7);
  }

  Future<void> getSuggestedCommunity() async {
    recommendedCommunity = await getRecommendedCommunity();
    DateTime now = DateTime.now();
    DateTime date = recommendedCommunity!.createdAt;
    bool isToday = (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day);
    setState(() {
      if (isToday) {
        todayNotifications.add(recommendedCommunity!);
      } else {
        earlierNotifications.add(recommendedCommunity!);
      }
    });
  }

  Future<void> fetchData() async {
    try {
      notifications = await fetchNotifications();
      if (notifications.isEmpty) {
        await getSuggestedCommunity();
      } else {
        final today = DateTime.now().toLocal();
        setState(() {
          todayNotifications = notifications.where((n) {
            final notificationDate = n.createdAt.toLocal();
            return notificationDate.year == today.year &&
                notificationDate.month == today.month &&
                notificationDate.day == today.day;
          }).toList();

          earlierNotifications = notifications.where((n) {
            final notificationDate = n.createdAt.toLocal();
            return !todayNotifications.contains(n) &&
                notificationDate.isBefore(today);
          }).toList();
          print('notifications state ${notifications.isNotEmpty}');

          print('todayNotifications  state ${todayNotifications.isNotEmpty}');
          print(
              'earliear notification state ${earlierNotifications.isNotEmpty}');
        });
      }
    } catch (e) {
      print(e);
      if (notifications.isEmpty) {
        await getSuggestedCommunity();
      }
    } finally {
      setState(() {
        isLoading = false;
      });
      print(isLoading);
    }
  }

  Future<void> unreadNotificationsCount() async {
    int number = await getNotificationUnreadCount();
    setState(() {
      unreadNotifications = number;
    });
  }

  /// Builds the selected page content based on the selected tab index.
  Widget _buildSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return isLoading
            ? LoaderWidget(dotSize: 10, logoSize: 100)
            : NotificationPage(
                todayNotifications: todayNotifications,
                earlierNotifications: earlierNotifications,
                notifications: notifications,
                isAllRead: widget.isAllRead,
              );

      case 1:
        return isLoading
            ? LoaderWidget(dotSize: 10, logoSize: 100)
            : MessageInbox(
                isAllRead: widget.isAllRead,
                newMessage: widget.newMessage,
                setNewMessage: widget.setNewMessage,
              );
      default:
        return LoaderWidget(
          dotSize: 10,
          logoSize: 100,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBar(
          tabs: ['Notifications', 'Messages'],
          onIndexChanged: _onIndexChanged,
        ),
        Expanded(
          child: _buildSelectedPage(),
        ),
      ],
    );
  }
}
