import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/get_specific_category.dart';
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
  List<Community> communities = [];
  List<Community> communityData = [];
  List<Community> filteredList = [];
  bool isShowMorePressed = false;

  @override
  void initState() {
    super.initState();
    getCommunityData();
    _updateDisplayList();
  }

  void getCommunityData() async {
    GetSpecificCommunity getSpecificCommunity = GetSpecificCommunity();
    List<Community> communities = await getSpecificCommunity.getCommunities(
      "🌍 Top globally",
    );
    setState(() {
      this.communities = communities;
    });
    communityData = communities;
  }

  void _updateDisplayList() {
    if (isShowMorePressed) {
      filteredList = List.from(communityData);
    } else {
      filteredList = communityData.take(4).toList();
    }
  }

  void updateFilteredList(List<Community> filteredList) {
    setState(() {
      this.filteredList = List.from(filteredList);
    });
  }

  void toggleShowMorePressed() {
    setState(() {
      isShowMorePressed = !isShowMorePressed;
      _updateDisplayList();
    });
  }

  void navigateToFinalContentPage(Community selectedCommunity) {
    Navigator.of(context).pushNamed('/final-content-page', arguments: {
      'title': widget.title,
      'content': widget.content,
      'link': widget.link,
      'image': widget.image,
      'imageWeb': widget.imageWeb,
      'video': widget.video,
      'videoWeb': widget.videoWeb,
      'pollOptions': widget.pollOptions,
      'selectedDay': widget.selectedDay,
      'createPoll': widget.createPoll,
      'isLinkAdded': widget.isLinkAdded,
      'community': [selectedCommunity],
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Community> displayList =
        filteredList.isNotEmpty ? filteredList : communityData;

    return Scaffold(
      body: Column(
        children: [
          ButtonlesHeader(
            text: "Post to",
            onIconPress: () {
              Navigator.pop(context);
            },
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
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print('tap detected');
                          navigateToFinalContentPage(displayList[index]);
                        },
                        child: CommunitiesCard(
                          communityName: displayList[index].name,
                          communityIcon: displayList[index].image!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 370,
            height: 50,
            child: OutlinedButton(
              onPressed: toggleShowMorePressed,
              style: OutlinedButton.styleFrom(
                  side: BorderSide(
                color: Colors.blue,
              )),
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