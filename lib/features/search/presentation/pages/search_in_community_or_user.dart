import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/best_and_new_widgets.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';

class SearchInCommunityOrUser extends StatefulWidget {

  final String communityOrUserName;
  final String communityOrUserIcon;

  SearchInCommunityOrUser({
    Key? key,
    required this.communityOrUserName,
    required this.communityOrUserIcon,
    }) : super(key: key);

  @override
  State<SearchInCommunityOrUser> createState() => _SearchInCommunityOrUserState();
}

class _SearchInCommunityOrUserState extends State<SearchInCommunityOrUser> {

  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String? searchItem ;
  String? sortFilter;
  String? timeFilter;
  List filteredList = [];
  String communityOrUserName = '';    
  String communityOrUserIcon = '';

  void navigateFilterTop () {
    Navigator.of(context).pushNamed('/community-or-user-search-results', arguments: {
      'searchItem': searchItem,
      'communityOrUserName': communityOrUserName,
      'communityOrUserIcon': communityOrUserIcon,
      'sortFilter': 'Top',
      'timeFilter': 'All time',
      }
    );
  }

  void navigateFilterNew () {
    Navigator.of(context).pushNamed('/community-or-user-search-results', arguments: {
      'searchItem': searchItem,
      'communityOrUserName': communityOrUserName,
      'communityOrUserIcon': communityOrUserIcon,
      'sortFilter': 'New',
      }
    );
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

  void navigateToCommunityOrUserSearch (String searchItem) {
    Navigator.of(context).pushNamed('/community-or-user-search-results',
    arguments: {
      'searchItem' : searchItem,
      'communityOrUserName' : communityOrUserName,
      'communityOrUserIcon': communityOrUserIcon,
    });
  }

  @override 
  void initState() {
    communityOrUserName = widget.communityOrUserName;
    communityOrUserIcon = widget.communityOrUserIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                CustomSearchBar(
                  formKey: searchForm,
                  hintText: 'Search',
                  updateSearchItem: updateSearchItem,
                  navigateToSearchResult: navigateToCommunityOrUserSearch,
                  navigateToSuggestedResults: () {},
                  initialBody: '',
                  communityOrUserName: communityOrUserName,
                  communityOrUserIcon: communityOrUserIcon,
                  isContained: true,
                ),
                InkWell(
                  onTap: () {}, // navigate to home page 
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            BestAndNewWidget(
              icon: Icons.rocket_launch_outlined,
              bestOrNew: 'Best of ',
              communityOrUserName: communityOrUserName,
              onTap: navigateFilterTop,
            ),
            BestAndNewWidget(
              icon: Icons.new_releases_outlined,
              bestOrNew: 'New in ',
              communityOrUserName: communityOrUserName,
              onTap: navigateFilterNew,
            ),
          ],
        ),
      ),
    );
  }
}