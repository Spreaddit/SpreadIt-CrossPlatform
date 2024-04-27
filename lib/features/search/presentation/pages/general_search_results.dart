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

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String? searchItem ;
  List filteredList = [];
  List labelsList = ['Posts', 'Communities', 'Comments', 'Media', 'People'];
  int selectedIndex = 0;
  List<Widget> pages = [
      PostsPageView(),
      CommunitiesPageView(),
      CommentsPageView(),
      MediaPageView(),
      PeoplePageView(),
    ];
  PageController _pageController = PageController(initialPage: 0);  


  void onSearch(List filteredList) {
    setState(() {
      this.filteredList = List.from(filteredList);
    });
  }

  void updateSearchItem(String value) {
    searchItem = value;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomSearchBar(
            hintText: 'hello',
            updateSearchItem: updateSearchItem,
          ),
          SizedBox(height: 8),
          SearchResultHeader(
            labels: labelsList,
            onTabSelected: onTabSelected,
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