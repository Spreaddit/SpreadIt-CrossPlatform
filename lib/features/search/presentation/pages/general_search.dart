import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/recent_searches.dart';
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
  List filteredList = [];
  List communityList = 
   [
      {
        'name': 'r/3abbas',
        'icon': './assets/images/LogoSpreadIt.png',
      },
      {
        'name': 'r/AskReddit',
        'icon': './assets/images/LogoSpreadIt.png',
      },
      {
        'name': 'Mayettin el software',
        'icon': './assets/images/LogoSpreadIt.png',
      },
      {
        'name': '3abbasTani',
        'icon': './assets/images/LogoSpreadIt.png',
      },
   ];

   List usersList = 
   [
      {
        'name': 'r/3abbas',
        'icon': './assets/images/LogoSpreadIt.png',
      },
      {
        'name': 'r/AskReddit',
        'icon': './assets/images/LogoSpreadIt.png',
      },
      {
        'name': 'Mayettin el software',
        'icon': './assets/images/LogoSpreadIt.png',
      },
      {
        'name': '3abbasTani',
        'icon': './assets/images/LogoSpreadIt.png',
      },
   ];


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
      body: Column(
          children: [
            Row(
              children: [
                CustomSearchBar(
                  hintText: 'Search',
                  searchList: [],
                  updateSearchItem: updateSearchItem,
                  onSearch: onSearch,
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
            if(filteredList.isEmpty)
              RecentSearches(),
              TrendingMenu(),  
            if(filteredList.isNotEmpty)
             Column(
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
                  onTap: () {},  // naviagate to el page el 3emalaqa di
                  child: Text('Search for "$searchItem"' ),
                ),
              ],)  
          ],
        ),
    );
  }
}

/*TO DOS:
1) logic el search nafso 
2) a-display elwidget bta3et el returned query 
3) can i pass 2 lists simultaneously? aw at least wa7da wara el tania bas el final display yetla3 lamma el 2 yekhallaso
4) ezzay a-check en el search bar fadi? (ha7tag form key w parameter ghaleban)
5) ana mosta7il akhallas el kalam da kollo by next week
6) aoi calls (agib el lists ml back)
*/