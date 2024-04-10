import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            //TODO: IMPLEMENT TRENDS
            children: [
              PostFeed(
                postCategory: PostCategories.hot,
                showSortTypeChange: false,
              ),
            ],
          ),
        ),
      ),
      endDrawer: HomePageDrawer(),
    );
  }
}
