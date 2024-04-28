import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_communities.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/community_element.dart';

class CommunitiesPageView extends StatefulWidget {
  final String searchItem;

  const CommunitiesPageView({Key? key, required this.searchItem}) : super(key: key);

  @override
  State<CommunitiesPageView> createState() => _CommunitiesPageViewState();
}

class _CommunitiesPageViewState extends State<CommunitiesPageView> {

  Map<String,dynamic> communities = {};
  List<Map<String, dynamic>> mappedCommunities = [];
  
  @override
  void initState() {
    super.initState();
    getCommunitiesResults();
  }

  void getCommunitiesResults() async {
    communities = await getCommunitiesSearchResults(widget.searchItem);
    mappedCommunities = extractCommunityDetails(communities);
    setState(() {});
  }

  List<Map<String, dynamic>> extractCommunityDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedCommunities = [];
    for (var community in results) {
      mappedCommunities.add({
        'communityName': community['communityName'],
        'communityProfilePic': community['communityProfilePic'],
        'communityInfo': community['communityInfo'],
      });
    }
    return mappedCommunities;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: mappedCommunities.length,
            itemBuilder: (context, index) {
              return CommunityElement(
                communityName: mappedCommunities[index]['communityName'],
                communityDescription: mappedCommunities[index]['communityInfo'],
                communityIcon: mappedCommunities[index]['communityProfilePic'],
                );
            }
          ),
        ],
      ), 
    );
  }
}

/* TO DOS :
1) akhod boolean el community da followed walla laa w 3ala asaso ba-render el button
2) mock service  */