import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/best_and_new_widgets.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';

class SearchInCommunityOrUser extends StatefulWidget {

  final String communityOrUserName;
  final String communityOrUserIcon;
  final bool fromUserProfile;
  final bool fromCommunityPage;

  SearchInCommunityOrUser({
    Key? key,
    required this.communityOrUserName,
    required this.communityOrUserIcon,
    required this.fromUserProfile,
    required this.fromCommunityPage,
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
  bool? fromUserProfile;
  bool? fromCommunityPage;

  void navigateFilterTop () {
    if (searchItem == '') {
      CustomSnackbar(content:'you must enter some text to search for').show(context);
    }
    else {
      Navigator.of(context).pushNamed('/community-or-user-search-results', arguments: {
        'searchItem': searchItem,
        'communityOrUserName': communityOrUserName,
        'communityOrUserIcon': communityOrUserIcon,
        'sortFilter': 'Top',
        'timeFilter': 'All time',
        'fromUserProfile': fromUserProfile,
        'fromCommunityPage': fromCommunityPage,
        }
      );
    }
  }

  void navigateFilterNew () {
    if (searchItem == '') {
      CustomSnackbar(content:'you must enter some text to search for').show(context);
    }
    else {
      Navigator.of(context).pushNamed('/community-or-user-search-results', arguments: {
        'searchItem': searchItem,
        'communityOrUserName': communityOrUserName,
        'communityOrUserIcon': communityOrUserIcon,
        'sortFilter': 'New',
        'fromUserProfile': fromUserProfile,
        'fromCommunityPage': fromCommunityPage,
        }
      );
    }  
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
      'fromUserProfile': fromUserProfile,
      'fromCommunityPage': fromCommunityPage,
    });
  }

  @override 
  void initState() {
    communityOrUserName = widget.communityOrUserName;
    communityOrUserIcon = widget.communityOrUserIcon;
    fromUserProfile = widget.fromUserProfile;
    fromCommunityPage = widget.fromCommunityPage;
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
                  onTap: () => Navigator.pop(context),
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