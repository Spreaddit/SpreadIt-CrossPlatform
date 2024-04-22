import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/sort_menu.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/user_info.dart';

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
  List<Post> newItems = [];
  List<Post> existingItems = [];
  final ScrollController _scrollController = ScrollController();
  bool _loadingMore = false;

  @override
  void initState() {
    currentPostCategory = widget.postCategory;
    isLoading = true;
    super.initState();
    fetchData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
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
      newItems.addAll(fetchedItems);
      isLoading = false;
      _loadingMore = false;
      _loadMore();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (!_loadingMore) {
      setState(() {
        _loadingMore = true;
      });
      fetchExistingItems();
    }
  }

  void fetchExistingItems() {
    if (existingItems.length < newItems.length) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          existingItems.addAll(newItems.take(7));
          _loadingMore = false;
        });
      });
    }
  }

  void onCategoryChanged(PostCategories postCategory) {
    if (postCategory == currentPostCategory) return;
    if (!mounted) return;
    setState(() {
      currentPostCategory = postCategory;
      newItems.clear();
      existingItems.clear();
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
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
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
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: redditOrange,
                        )
                      : Column(
                          children: [
                            for (int i = 0; i < existingItems.length; i++)
                              Column(
                                children: [
                                  PostWidget(
                                    post: existingItems[i],
                                    isUserProfile: currentPostCategory ==
                                            PostCategories.user ||
                                        (UserSingleton().user != null &&
                                            existingItems[i].username ==
                                                UserSingleton().user!.username),
                                  ),
                                  Divider(
                                    height: 20,
                                    thickness: 0.2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            if (_loadingMore)
                              existingItems.length != newItems.length
                                  ? SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _LoadingMoreIndicator(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                            "Hooray! You checked everything for today!"),
                                      ),
                                    ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingMoreIndicator extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: shrinkOffset,
      child: Center(
        child: CircularProgressIndicator(
          color: redditOrange,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 20.0;

  @override
  double get minExtent => 0.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
