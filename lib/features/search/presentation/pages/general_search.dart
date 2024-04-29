import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/recent_searches.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/trending_widgets/trending_menu.dart';
import '../widgets/search_display_list.dart';


class GeneralSearch extends StatefulWidget {
  const GeneralSearch({Key? key}) : super(key: key);

  @override
  State<GeneralSearch> createState() => _GeneralSearchState();
}

class _GeneralSearchState extends State<GeneralSearch> {

  final GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  String? searchItem ;

  void updateSearchItem(String value) {
    setState(() => searchItem = value);
    searchForm.currentState!.save();
  }

  void navigateToGeneralSearchResults(String searchItem) {
    Navigator.of(context).pushNamed('./general-search-results', arguments : {
      'searchItem': searchItem,
    }); 
  }

  void navigateToSuggestedResults() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: CustomSearchBar(
                      formKey: searchForm,
                      hintText: 'Search',
                      navigateToSearchResult: navigateToGeneralSearchResults,
                      updateSearchItem: updateSearchItem,
                      navigateToSuggestedResults: navigateToSuggestedResults,
                    ),
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
              (searchItem == null || RegExp(r'^[\W_]+$').hasMatch(searchItem!) ) ?
                Column(
                  children: [
                    RecentSearches(),
                    TrendingMenu(),
                  ],
                ) :
                SuggestedResults(), 
            ],
          ),
      ),
    );
  }
}

/*TO DOS:

1) api el trending 
2) a-display elwidget bta3et el returned query 
*/