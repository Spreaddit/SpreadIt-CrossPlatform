import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/pages/notification_page.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import '../../../generic_widgets/custom_bar.dart';
import '../../../homepage/presentation/widgets/post_feed.dart';
import '../../../user_profile/presentation/widgets/comments.dart';

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
