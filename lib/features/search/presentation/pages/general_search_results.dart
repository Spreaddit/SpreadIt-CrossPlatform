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
  List filteredList = [];
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
    pages.add(CommentsPageView());
    pages.add(MediaPageView());
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
    print('tao detected');
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
                onPressed: () {},   // navigate to home page
                icon: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
              CustomSearchBar(
                formKey: searchForm,
                hintText: '',
                updateSearchItem: updateSearchItem,
                navigateToSearchResult: navigateToGeneralSearchParam,
                navigateToSuggestedResults: navigateToGeneralSearch,
                initialBody: searchItem,
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