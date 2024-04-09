import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_post/data/get_communities_list.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List communityData = [];

  @override
  void initState() {
  super.initState();
  // Call async function in initState
  _fetchCommunityData();
}

void _fetchCommunityData() async {
  // Await for the future to complete
  List<dynamic> communities = await getCommunitiesList();
  // Update state inside setState
  setState(() {
    communityData = communities;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: communityData.length ,
            itemBuilder: (context, index) {
              Column(
                children: [
                  Text(communityData[index]['name']),
                  Text(communityData[index]['category']),
                  Text(communityData[index]['communityType']),
                  Text(communityData[index]['description']),
                  //Image(image: communityData[index]['image'],),
                  //Text(communityData[index]['memberCount']),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: communityData[index]['rules'].length,
                    itemBuilder: (context, listIndex) {
                      return Column(
                        children: [
                          Text(communityData[index]['rules'][listIndex]['title']),
                          Text(communityData[index]['rules'][listIndex]['description']),
                          Text(communityData[index]['rules'][listIndex]['reportReason']),
                        ],
                      );
                    }
                  ),
                  Text(communityData[index]['dateCreated']),
                  //Image(image:communityData[index]['communityBanner']),
                ],
              );
            }
          ),
        ),
      ]
    ),
  );
  }
}