import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_post/data/get_communities_list.dart';
import '../../../generic_widgets/search_bar.dart';
import '../widgets/header_and_footer_widgets/buttonless_header.dart';
import '../widgets/communities_search_card.dart';

class PostToCommunity extends StatefulWidget { 

  final String title;
  final String content;
  final String? link;
  final File? image;
  final Uint8List? imageWeb;
  final File? video;
  final Uint8List? videoWeb;
  final List<String> pollOptions;
  final int selectedDay;
  final bool createPoll;
  final bool isLinkAdded;
  
  const PostToCommunity({
    Key? key,
    required this.title,
    required this.content,
    this.link,
    this.image,
    this.imageWeb,
    this.video,
    this.videoWeb,
    required this.pollOptions,
    required this.selectedDay,
    required this.createPoll,
    required this.isLinkAdded,
    }) : super(key: key);

  @override
  State<PostToCommunity> createState() => _PostToCommunityState();
}

class _PostToCommunityState extends State<PostToCommunity> {

  List<Map<String,dynamic>> communities = [];
  List<Map<String, dynamic>> communityData = [];
  List<Map<String, dynamic>> filteredList = [];
  bool isShowMorePressed = false;

  @override
  void initState() {
    super.initState();
    getCommunityData();
    _updateDisplayList();
  }

  void getCommunityData () async {
    List<Map<String,dynamic>> communities = await getCommunitiesList();
    setState(() {
      this.communities = communities ;
    });
    mapCommunityData();
  }

  void mapCommunityData () {
    communityData = communities.map((item) {
      return {
        'communityName': item['name'],
        'communityIcon': item['image'],
        'communityRules': item['rules'],
      };
    }).toList();
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

  void navigateToFinalContentPage(Map<String, dynamic> selectedCommunity) {
    Navigator.of(context).pushNamed('/final-content-page',
     arguments:{
      'title': widget.title,
      'content': widget.content,
      'link': widget.link,
      'image': widget.image,
      'imageWeb': widget.imageWeb,
      'video': widget.video,
      'videoWeb':widget.videoWeb,
      'pollOptions': widget.pollOptions,
      'selectedDay': widget.selectedDay,
      'createPoll': widget.createPoll,
      'isLinkAdded':widget.isLinkAdded,
      'community': [selectedCommunity], 
      }
    );
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
          onIconPress:  () {Navigator.pop(context);},
        ),
        CustomSearchBar(
          hintText: 'Search for a community',
          searchList: communityData,
          onSearch: updateFilteredList,
          ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: displayList.length ,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap:() {
                          print('tap detected');
                          navigateToFinalContentPage(displayList[index]);
                        },
                        child: CommunitiesCard(
                          communityName: displayList[index]['communityName'],
                          communityIcon: displayList[index]['communityIcon'],
                          ),
                      );
                      },
                    ),
              ),
            ],
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
 unit testing
 */