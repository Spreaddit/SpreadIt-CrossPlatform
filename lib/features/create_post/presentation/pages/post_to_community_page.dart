import 'package:flutter/material.dart';
import '../../../generic_widgets/search_bar.dart';
import '../widgets/header_and_footer_widgets/buttonless_header.dart';
import '../widgets/communities_search_card.dart';

class PostToCommunity extends StatefulWidget { 
  const PostToCommunity({Key? key}) : super(key: key);

  @override
  State<PostToCommunity> createState() => _PostToCommunityState();
}

class _PostToCommunityState extends State<PostToCommunity> {

    List<Map<String, dynamic>> communityData = [
    {
      'communityName':'r/Egypt',
      'online': '17 online',
      'communityIcon': "./assets/images/LogoSpreadIt.png",
    },
    {
      'communityName':'r/Developers',
      'online': '30 online',
      'communityIcon': "./assets/images/LogoSpreadIt.png",
    },
    {
      'communityName':'r/AskReddit',
      'online': '267 online',
      'communityIcon': "./assets/images/LogoSpreadIt.png",
    },
    {
      'communityName':'r/AskMasr',
      'online': '24 online',
      'communityIcon': "./assets/images/LogoSpreadIt.png",
    },
    {
      'communityName':'r/Artists',
      'online': '498 online',
      'communityIcon': "./assets/images/LogoSpreadIt.png",
    },
    {
      'communityName':'r/Emboidory',
      'online': '3 online',
      'communityIcon': "./assets/images/LogoSpreadIt.png",
    },
  ];

  List<Map<String, dynamic>> filteredList = [];
  bool isShowMorePressed = false;

  @override
  void initState() {
    super.initState();
    _updateDisplayList();
  }

  void _updateDisplayList() {
    if (isShowMorePressed) {
      filteredList = List.from(communityData);
    } 
    else {
      filteredList = communityData.take(4).toList();
    }
  }

  void updateFilteredList(List<Map<String, dynamic>> filteredList) {
    setState(() {
      this.filteredList = List.from(filteredList);
    });
  }
  
  void toggleShowMorePressed () {
    setState(() {
      isShowMorePressed = !isShowMorePressed;
      _updateDisplayList();
    });
  }

  void navigateToFinalContentPage() {
    Navigator.of(context).pushNamed('/final-content-page');
  }

  void navigateToPrimaryContentPage() {
    Navigator.of(context).pushNamed('/primary-content-page');
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> displayList =
      filteredList.isNotEmpty ? filteredList : communityData;

    return Scaffold(
      body: Column(
        children: [
        ButtonlesHeader(
          text: "Post to",
          onIconPress: navigateToPrimaryContentPage,
        ),
        CustomSearchBar(
          hintText: 'Search for a community',
          searchList: communityData,
          onSearch: updateFilteredList,
          ),
        Expanded(
          child: GestureDetector(
            onTap: navigateToFinalContentPage,
            child: ListView.builder(
              itemCount: displayList.length ,
              itemBuilder: (context, index) {
                return CommunitiesCard(
                  communityName: displayList[index]['communityName'],
                  online: displayList[index]['online'],
                  communityIcon: displayList[index]['communityIcon'],
                  );
                },
              ),
          ),
        ),
          Container(
              width:370,
              height:50,
              child: OutlinedButton(
                onPressed: toggleShowMorePressed,
                style: OutlinedButton.styleFrom(
                  side:BorderSide(
                    color: Colors.blue,
                  )
                ),
                child: Text(
                  !isShowMorePressed ? "See more" : "See less",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}

/*
TODOs:
1) agahhez el api call elli ha-get biha el communities 
3) pass el community lel final content page 
4) mock service 
5) unit testing
 */