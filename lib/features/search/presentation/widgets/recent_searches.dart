import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/search/data/delete_search_history.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_history.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {

  List recents = [];
  List recentSearches = [];

  @override
  void initState() {
    super.initState();
    getRecentSearches();
  }

  void getRecentSearches () async {
    recentSearches = await getSeacrhHistory();
    setRecentVector();
  }

  void setRecentVector () {
    setState(() => recents = recentSearches.map((item) => item["query"]).toList());
  }

  void deleteRecentSearch (String query) async{
    int response = await deleteSearchHistory(query);
    getSeacrhHistory();
  }

  void navigateToSearchResults (String searchItem) async {
    Navigator.of(context).pushNamed('/general-search-results', arguments : {
      'searchItem': searchItem,
    }); 
  }

  @override
  Widget build(BuildContext context) { 
    if (recents != [] || recents.isNotEmpty) {
      return  Container(
        margin : EdgeInsets.fromLTRB(10, 0, 10, 2),
        child: ListView.builder(
          padding: EdgeInsets.only(top:3),
          shrinkWrap: true,
          itemCount: min(recents.length, 5),
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  onTap: () => navigateToSearchResults(recents[index]),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(Icons.browse_gallery_outlined),
                      ),
                      Text(
                        recents[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => deleteRecentSearch(recents[index]),
                      icon: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
    else {
      return Container();
    }
  }
}
