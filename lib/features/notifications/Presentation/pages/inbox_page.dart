import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/pages/notification_page.dart';
import '../../../generic_widgets/custom_bar.dart';

/// A StatefulWidget representing the Saved page where users can view their saved posts and comments.
class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  int _selectedIndex = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Builds the selected page content based on the selected tab index.
  Widget _buildSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return NotificationPage();
      case 1:
        return NotificationPage(); //To be messages
      default:
        return NotificationPage();
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomBar(
            tabs: ['Notifications', 'Messages'],
            onIndexChanged: _onIndexChanged,
          ),
          Expanded(
            child: _buildSelectedPage(),
          ),
        ],
      ),
    );
  }
}
