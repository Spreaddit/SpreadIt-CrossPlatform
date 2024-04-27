import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/media_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_result_header.dart';

class InCommunityOrUserSearchResults extends StatefulWidget {

  final String? sortFilter;
  final String? timeFilter;

  const InCommunityOrUserSearchResults({
    Key? key,
    this.sortFilter,
    this.timeFilter,
  }) : super(key: key);

  @override
  State<InCommunityOrUserSearchResults> createState() => _InCommunityOrUserSearchResultsState();
}

class _InCommunityOrUserSearchResultsState extends State<InCommunityOrUserSearchResults> {
  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String? searchItem ;
  List filteredList = [];
  List labelsList = ['Posts', 'Media'];
  int selectedIndex = 0;
  late List<Widget> pages ;
  late PageController _pageController;  


    @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    pages = [
      Center(child: Text('Posts')),
      MediaPageView(
        sortFilter: widget.sortFilter,
        timeFilter: widget.timeFilter,
      ),
    ];
  }

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
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
              ),
              CustomSearchBar(
                hintText: 'hello',
                updateSearchItem: updateSearchItem,
              ),
            ],
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