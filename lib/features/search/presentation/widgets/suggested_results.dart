import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/data/post_search_log.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_display_list.dart';

/// This class displays the suggested results that appear when the user writes a search query to the [CustomsearchBar]

class SuggestedResults extends StatefulWidget {
  final String searchItem;
  final List<Map<String,dynamic>> communities;
  final List<Map<String,dynamic>> users;

  const SuggestedResults({
    Key? key,
    required this.searchItem,
    required this.communities,
    required this.users,
    }) : super(key: key);

  @override
  State<SuggestedResults> createState() => _SuggestedResultsState();
}

class _SuggestedResultsState extends State<SuggestedResults> {

  String searchItem = '';

  void handleTap() {
    saveSearchLog();
    navigateToGeneralSearchResults();
  }

  void saveSearchLog () async {
    await postSearchLog(widget.searchItem,'normal', null, null , false);
  }

  void navigateToGeneralSearchResults() {
    Navigator.of(context).pushNamed('/general-search-results', arguments : {
      'searchItem': widget.searchItem,
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
            if (widget.communities.isNotEmpty)
            Column(
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
                  displayList: widget.communities,
                  type: 'community',
                ),
              ],
            ),
            if (widget.users.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'People',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SearchDisplayList(
                  displayList: widget.users,
                  type: 'user',
                ),
              ],
            ),
            InkWell(
              onTap: navigateToGeneralSearchResults,  
              child: Text(
                'Search for ${widget.searchItem}',
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
