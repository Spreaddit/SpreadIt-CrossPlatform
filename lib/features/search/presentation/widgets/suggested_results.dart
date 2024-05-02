import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_display_list.dart';

class SuggestedResults extends StatefulWidget {
  final String searchItem;

  const SuggestedResults({Key? key, required this.searchItem}) : super(key: key);

  @override
  State<SuggestedResults> createState() => _SuggestedResultsState();
}

class _SuggestedResultsState extends State<SuggestedResults> {

  List<Map<String, dynamic>> communities = [];
  List<Map<String, dynamic>> users = [];
  String searchItem = '';


  @override
  void initState() {
    searchItem = widget.searchItem;
    updateSuggestedResults();
    super.initState();
  }

  void updateSuggestedResults() async {
    Map<String,dynamic> response  = await getSuggestedResults(searchItem);
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

  void navigateToGeneralSearchResults() {
    Navigator.of(context).pushNamed('/general-search-results', arguments : {
      'searchItem': searchItem,
    }); 
  }

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Communities',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SearchDisplayList(
              displayList: communities,
              type: 'community',
            ),
            Text(
              'People',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SearchDisplayList(
              displayList: users,
              type: 'user',
            ),
            InkWell(
              onTap: navigateToGeneralSearchResults,  
              child: Text(
                'Search for $searchItem',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.blue[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
