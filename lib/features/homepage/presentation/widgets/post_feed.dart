import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/sort_menu.dart';
import 'package:spreadit_crossplatform/user_info.dart';

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
  final PostCategories postCategory;
  final String? subspreaditName;
  final String? timeSort;
  final String? username;
  final bool showSortTypeChange;
  final int startSortIndex;
  final int endSortIndex;

  PostFeed({
    required this.postCategory,
    this.subspreaditName,
    this.timeSort,
    this.username,
    this.showSortTypeChange = false,
    this.startSortIndex = 0,
    this.endSortIndex = 3,
  });

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  late PostCategories currentPostCategory;
  bool isLoading = true;
  List<Post> items = [];

  @override
  void initState() {
    currentPostCategory = widget.postCategory;
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (!mounted) return;

    List<Post> fetchedItems = await getFeedPosts(
      category: currentPostCategory,
      subspreaditName: widget.subspreaditName,
      timeSort: widget.timeSort,
      username: widget.username,
    );

    setState(() {
      if (fetchedItems.isEmpty) {
        CustomSnackbar(content: "No posts found").show(context);
      }
      items = fetchedItems;
      isLoading = false;
    });
  }

  void onCategoryChanged(PostCategories postCategory) {
    if (postCategory == currentPostCategory) return;
    if (!mounted) return;
    setState(() {
      currentPostCategory = postCategory;
      items.clear();
      isLoading = true;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return fetchData();
      },
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              if (widget.showSortTypeChange)
                Container(
                  color: const Color.fromARGB(255, 226, 226, 226),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SortTypeMenu(
                        onCategoryChanged: onCategoryChanged,
                        startSortIndex: widget.startSortIndex,
                        endSortIndex: widget.endSortIndex,
                      ),
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 0,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        PostWidget(
                            post: items[index],
                            isUserProfile:
                                currentPostCategory == PostCategories.user ||
                                    (UserSingleton().user != null &&
                                        items[index].username ==
                                            UserSingleton().user!.username)),
                        Divider(
                          height: 20,
                          thickness: 0.2,
                          color: Colors.black,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
