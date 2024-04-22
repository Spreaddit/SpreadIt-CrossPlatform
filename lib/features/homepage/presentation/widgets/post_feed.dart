import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/sort_menu.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:shimmer/shimmer.dart';

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
  bool isRefreshing = false;

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

  @override
  void didUpdateWidget(covariant PostFeed oldWidget) {
    if (widget.postCategory != oldWidget.postCategory) {
      fetchData();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> fetchData() async {
    if (!mounted) return;

    setState(() => isLoading = true);

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
      existingItems.addAll(newItems.take(7));
      isRefreshing = false;
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
        setState(() {
          isRefreshing = true;
        });
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
                      ? _buildShimmerLoading()
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: existingItems.length != newItems.length
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
        ],
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
