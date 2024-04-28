import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_display_list.dart';

class SuggestedResults extends StatefulWidget {
  const SuggestedResults({Key? key}) : super(key: key);

  @override
  State<SuggestedResults> createState() => _SuggestedResultsState();
}

class _SuggestedResultsState extends State<SuggestedResults> {

  List<Map<String, dynamic>> communities = [];
  List<Map<String, dynamic>> users = [];


  @override
  void initState() {
    updateSuggestedResults();
    super.initState();
  }

  void updateSuggestedResults() async {
    Map<String,dynamic> response  = await getSuggestedResults();
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
    Navigator.of(context).pushNamed('./general-search-results', arguments : {
      'searchItem': '',
    }); 
  }

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
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
            ),
            InkWell(
              onTap: navigateToGeneralSearchResults,  
              child: Text(
                'Search for kwak',
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

// 'Search for "$searchItem"'

//to do : akhod el searchitem hena kaman