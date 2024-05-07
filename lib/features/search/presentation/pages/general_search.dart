import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/recent_searches.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/trending_widgets/trending_menu.dart';
import '../widgets/search_display_list.dart';

/// This is what the user first sees when he taps the search icon from the home page.
/// The class diplays a [CustomSearchBar] in which the user can write his search query, his [RecentSearches] if any, and today's trending posts through [TrendingMenu].
/// When the user starts typing is search query, a list of [SuggestedResults] gets displays, this class also handles the logic behind updating this list.
class GeneralSearch extends StatefulWidget {
  const GeneralSearch({Key? key}) : super(key: key);

  @override
  State<GeneralSearch> createState() => _GeneralSearchState();
}

class _GeneralSearchState extends State<GeneralSearch> {

  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String searchItem = '' ;
  List<Map<String, dynamic>> communities = [];
  List<Map<String, dynamic>> users = [];

  void updateSearchItem(String value) {
    setState(() => searchItem = value);
    searchForm.currentState!.save();
    updateSuggestedResults();
  }

  void navigateToGeneralSearchResults(String searchItem) {
    Navigator.of(context).pushNamed('/general-search-results', arguments : {
      'searchItem': searchItem,
    }); 
  }

  void navigateToSuggestedResults() {
    print('called from searchbar');
    setState(() {});
  }

  void updateSuggestedResults() async {
    Map<String,dynamic> response  = await GetSuggestedResults().getSuggestedResults(searchItem);
    Map<String, List<Map<String, dynamic>>> data = await separateCommunitiesAndUsers(response);
    communities = data['communities']!;
    users = data['users']!;
    setState((){});
  }

  Future<Map<String, List<Map<String, dynamic>>>> separateCommunitiesAndUsers(Map<String, dynamic> response) async {
    List<Map<String, dynamic>> communities = [];
    List<Map<String, dynamic>> users = [];
    if (response.containsKey('communities')) {
      for (var element in response['communities']) {
        if (element is Map<String, dynamic>) {
          communities.add(element);
        }
      }
    }
    if (response.containsKey('users')) {
      for (var element in response['users']) {
        if (element is Map<String, dynamic>) {
          users.add(element);
        }
      }
    }

    return {'communities': communities, 'users': users};
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, right:5),
                      child: CustomSearchBar(
                        formKey: searchForm,
                        hintText: 'Search',
                        navigateToSearchResult: navigateToGeneralSearchResults,
                        updateSearchItem: updateSearchItem,
                        navigateToSuggestedResults: navigateToSuggestedResults,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:5),
                    child: InkWell(
                      onTap: () => Navigator.pop(context), 
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (searchItem.isEmpty || RegExp(r'^[\W_]+$').hasMatch(searchItem) ) ?
                Column(
                  children: [
                    RecentSearches(),
                    TrendingMenu(),
                  ],
                ) :
                SuggestedResults(
                  searchItem: searchItem,
                  communities: communities,
                  users: users,
                ), 
            ],
          ),
      ),
    );
  }
}

