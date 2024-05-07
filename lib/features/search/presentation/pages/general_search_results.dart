import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/media_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/posts_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/comments_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/communities_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/people_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_result_header.dart';

/// This class gets displayed in 3 cases:
/// 1) when the user taps 'enter' after typing a search query in the [CustomSearchBar].
/// 2) when the user taps one of the suggested community pages or user profiles.
/// 3) when the user taps one of the trending posts.
/// This class displays some [CustomPageView]s to display the search results.
/// These page views include [PostsPageView], [CommunitiesPageView], [CommentsPageView], [MediaPageView], and [PeoplePageView].
/// Initially , [PostsPageView] is displayed , but on label tap, the page is animated to the required page view

class SearchResult extends StatefulWidget {

  final String searchItem ;

   const SearchResult({
    Key? key,
    required this.searchItem,
    }) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String searchItem = '' ;
  List labelsList = ['Posts', 'Communities', 'Comments', 'Media', 'People'];
  int selectedIndex = 0;
  List<Widget> pages = [];
  PageController _pageController = PageController(initialPage: 0);  

  @override
  void initState() {
    super.initState();
    searchItem = widget.searchItem;
    pages.add(PostsPageView(searchItem: searchItem));
    pages.add(CommunitiesPageView(searchItem: searchItem)); 
    pages.add(CommentsPageView(searchItem: searchItem));
    pages.add(MediaPageView(searchItem: searchItem));
    pages.add(PeoplePageView(searchItem: searchItem));
  }


  void updateSearchItem(String value) {
    setState(() => searchItem = value);
    searchForm.currentState!.save();
  }

  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
      );
    });
  }

  void navigateToGeneralSearch() {
    Navigator.pop(context);
  }

  void navigateToGeneralSearchParam(String searchItem) {
    Navigator.pop(context,searchItem);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),   
                icon: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
              Expanded(
                child: CustomSearchBar(
                  formKey: searchForm,
                  hintText: '',
                  updateSearchItem: updateSearchItem,
                  navigateToSearchResult: navigateToGeneralSearchParam,
                  navigateToSuggestedResults: navigateToGeneralSearch,
                  initialBody: searchItem,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SearchResultHeader(
            labels: labelsList,
            onTabSelected: onTabSelected,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: CustomPageView(
              pages: pages,
              currentIndex: selectedIndex,
              pageController: _pageController,
            ),
          ),
        ],
      ),
    );
  }
}