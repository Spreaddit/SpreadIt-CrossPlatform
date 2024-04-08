import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/sort_dropdown.dart';

/// This widget is a post feed display,
/// which takes [PostCategories] as a constructor parameter
/// and creates a post feed, by fetching posts from
/// the respective endpoint
///
/// This example shows how a post feed of best posts can be created
///
/// ```dart
/// PostFeed(
///   postCategory: PostCategories.best,
/// ),
/// ```
class PostFeed extends StatefulWidget {
  PostCategories postCategory;
  String? subspreaditName;
  String? timeSort;
  String? username;
  bool showSortTypeChange = false;

  PostFeed({
    required this.postCategory,
    this.subspreaditName,
    this.timeSort,
    this.username,
    this.showSortTypeChange = false,
  });

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  late PostCategories currentPostCategory;
  List<Post> items = [];

  @override
  void initState() {
    var currentPostCategory = widget.postCategory;
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Post> fetchedItems = await getFeedPosts(
      category: currentPostCategory,
      subspreaditName: widget.subspreaditName,
      timeSort: widget.timeSort,
      username: widget.username,
    );

    setState(() {
      if (fetchedItems.isEmpty) {
        CustomSnackbar(content: "an error occured. Please Refresh")
            .show(context);
      }
      items = fetchedItems;
    });
  }

  void onCategoryChanged(PostCategories postCategory) {
    setState(() {
      currentPostCategory = postCategory;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: Column(
        children: [
          if (widget.showSortTypeChange)
            SortTypeDropdown(
              onCategoryChanged: onCategoryChanged,
            ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return PostWidget(
                post: items[index],
              );
            },
          )
        ],
      ),
    );
  }
}
