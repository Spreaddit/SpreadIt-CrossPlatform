import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_display_list.dart';

class SuggestedResults extends StatefulWidget {
  const SuggestedResults({Key? key}) : super(key: key);

  @override
  State<SuggestedResults> createState() => _SuggestedResultsState();
}

class _SuggestedResultsState extends State<SuggestedResults> {

  List communityList = [];
  List usersList = [];


  @override
  void initState() {
    super.initState();
    updateSuggestedResults;
  }

  void updateSuggestedResults() async {
    List response  = await getSuggestedResults();
    mapSuggestedResults(response);
  }

  void mapSuggestedResults (List response) {
    setState(() {
      communityList = response.where((item) => item['type'] == 'community').toList();
      usersList = response.where((item) => item['type'] == 'user').toList();
    });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Communities'),
          SearchDisplayList(
            displayList: communityList,
          ),
          Text('People'),
          SearchDisplayList(
            displayList: usersList,
          ),
          InkWell(
            onTap: navigateToGeneralSearchResults,  
            child: Text('Search for kwak'),
          ),
        ],
      ),
    );
  }
}

// 'Search for "$searchItem"'

//to do : akhod el searchitem hena kaman