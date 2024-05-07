import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

/// A Widget for displaying the history page.
class HistoryPage extends StatelessWidget {
  /// Builds the widget for the history page.
  ///
  /// The [context] parameter represents the build context.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'History',
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: PostFeed(
        postCategory: PostCategories.recent,
        startSortIndex: PostCategories.recent.index,
        endSortIndex: PostCategories.upvoted.index,
        showSortTypeChange: true,
      ),
    );
  }
}
