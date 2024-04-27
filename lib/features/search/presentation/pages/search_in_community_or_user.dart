import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/best_and_new_widgets.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';

class SearchInCommunityOrUser extends StatefulWidget {
  const SearchInCommunityOrUser({Key? key}) : super(key: key);

  @override
  State<SearchInCommunityOrUser> createState() => _SearchInCommunityOrUserState();
}

class _SearchInCommunityOrUserState extends State<SearchInCommunityOrUser> {

  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String? searchItem ;
  String? sortFilter;
  String? timeFilter;
  List filteredList = [];
  String communityOrUserName = 'r/AskReddit';
  String communityOrUserIcon = './assets/images/SB-Standees-Spong-3_800x.png';

  void setSortFilter(String value) {
    setState(() => sortFilter = value);
  }

  void setTimeFilter(String value) {
    setState(() => timeFilter = value);
  }


  void navigateFilterTop () {
    setSortFilter('Top');
    setTimeFilter('All time');
    Navigator.of(context).pushNamed('/in-community-or-user-search-results', arguments: {
      'sortFilter': sortFilter,
      'timeFilter': timeFilter,
      }
    );
  }

  void navigateFilterNew () {
    setSortFilter('New');
    Navigator.of(context).pushNamed('/in-community-or-user-search-results', arguments: {
      'sortFilter': sortFilter,
      'timeFilter': timeFilter,
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
                  hintText: 'Search',
                  updateSearchItem: updateSearchItem,
                  communityOrUserName: communityOrUserName,
                  communityOrUserIcon: communityOrUserIcon,
                ),
                InkWell(
                  onTap: () {}, // navigate to home page 
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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