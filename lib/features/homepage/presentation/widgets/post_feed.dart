import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/sort_menu.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:shimmer/shimmer.dart';

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
  final bool isSavedPage;
  final ScrollController? scrollController;

  PostFeed({
    required this.postCategory,
    this.subspreaditName,
    this.timeSort,
    this.username,
    this.showSortTypeChange = false,
    this.startSortIndex = 0,
    this.endSortIndex = 3,
    this.isSavedPage = false,
    this.scrollController,
  });

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  late PostCategories currentPostCategory;
  bool isLoading = true;
  List<Post> newItems = [];
  List<Post> existingItems = [];
  late ScrollController _scrollController;
  bool _loadingMore = false;
  bool isRefreshing = false;
  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    currentPostCategory = widget.postCategory;
    isLoading = true;
    super.initState();
    setState(() {
      _scrollController = widget.scrollController ?? ScrollController();
    });
    fetchData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PostFeed oldWidget) {
    if (!mounted) return;
    if (widget.postCategory != oldWidget.postCategory) {
      setState(() {
        currentPostCategory = widget.postCategory;
        _scrollController = widget.scrollController ?? ScrollController();
        isLoading = true;
      });
      fetchData();
    }
    setState(() {
      _scrollController = ScrollController();
    });
    super.didUpdateWidget(oldWidget);
  }

  Future<void> fetchData() async {
    if (!mounted) return;

    List<Post> fetchedItems = await getFeedPosts(
      category: currentPostCategory,
      subspreaditName: widget.subspreaditName,
      timeSort: widget.timeSort,
      username: widget.username,
      page: page,
    );

    setState(() {
      if (fetchedItems.isEmpty) {
        CustomSnackbar(content: "No posts found").show(context);
      }
      newItems.clear();
      newItems = fetchedItems;
      isLoading = false;
      _loadingMore = false;
      existingItems = [...existingItems, ...newItems];
      isRefreshing = false;
      page = page + 1;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (!mounted) return;

    if (!_loadingMore) {
      setState(() {
        _loadingMore = true;
      });
      fetchData();
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
        if (mounted) {
          setState(() {
            isRefreshing = true;
          });
        }
        return fetchData();
      },
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        controller: _scrollController,
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
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 0,
              ),
              child: isLoading
                  ? _buildShimmerLoading()
                  : Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: existingItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PostWidget(
                                    isSavedPage: widget.isSavedPage,
                                    feedContext: context,
                                    post: existingItems[index],
                                    isUserProfile: currentPostCategory ==
                                            PostCategories.user ||
                                        (UserSingleton().user != null &&
                                            existingItems[index].username ==
                                                UserSingleton()
                                                    .user!
                                                    .username)),
                                Divider(
                                  height: 20,
                                  thickness: 0.2,
                                  color: Colors.black,
                                )
                              ],
                            );
                          },
                        ),
                        if (_loadingMore)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: existingItems.length != newItems.length ||
                                    _loadingMore
                                ? CircularProgressIndicator(
                                    color: Colors.grey,
                                  )
                                : Center(
                                    child: Text(
                                        "Hooray! You checked everything for today!"),
                                  ),
                          )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: !isRefreshing
                ? CircularProgressIndicator(
                    color: Colors.grey,
                  )
                : Text(""),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          period: Duration(milliseconds: 1000),
          child: Column(
            children: List.generate(
              10,
              (index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(),
                      title: Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                      subtitle: Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      title: Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
