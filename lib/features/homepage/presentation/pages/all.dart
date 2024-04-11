import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';

/// all posts displayed in different sorting orders (e.g., hot first, new first, etc...)
class AllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        currentPage: CurrentPage.all,
        context: context,
      ),
      body: PostFeed(
        postCategory: PostCategories.best,
        showSortTypeChange: true,
      ),
      endDrawer: HomePageDrawer(),
    );
  }
}
