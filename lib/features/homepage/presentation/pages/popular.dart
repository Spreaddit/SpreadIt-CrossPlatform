import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/left_menu.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';

/// popular trends page
class PopularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        currentPage: CurrentPage.popular,
        context: context,
      ),
      body: PostFeed(
        postCategory: PostCategories.best,
        showSortTypeChange: false,
      ),
      endDrawer: HomePageDrawer(),
      drawer: LeftMenu(),
    );
  }
}
