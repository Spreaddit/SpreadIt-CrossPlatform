import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/community_element.dart';

/// Responsible for displaying the search results for communities.
/// The class also displays a list of [CommunityElement] widgets, which is a Custom widget to display the community pages.
/// The class handles the logic of tapping a community search result, which is navigating to the corresponding coommunity page.
/// The class also handles the logic of pressing the 'Join/Unjoin' button by toggling the joining state.

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
    communities = await GetSearchResults().getSearchResults(widget.searchItem, 'communities','relevance');
    mappedCommunities = extractCommunityDetails(communities);
    setState(() {});
  }

  List<Map<String, dynamic>> extractCommunityDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedCommunities = [];
    try {
      for (var community in results) {
        mappedCommunities.add({
          'communityId' : community['communityId'] ?? (throw Exception('null')),
          'communityName': community['communityName'] ?? (throw Exception('null')),
          'communityProfilePic': community['communityProfilePic'] ?? (throw Exception('null')),
          'membersCount': community['membersCount'] ?? (throw Exception('null')),
          'communityInfo': community['communityInfo'] ?? (throw Exception('null')),
          'isFollowing': community['isFollowing'] ?? (throw Exception('null')),
        });
      }
      return mappedCommunities;
    }
    catch(e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (communities.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF4500),
          ),
        ),
      );
    }
    if (mappedCommunities.isEmpty) {
      return Image.asset('./assets/images/Empty_Toast.png');
    }
    else {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(top:3),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mappedCommunities.length,
              itemBuilder: (context, index) {
                return CommunityElement(
                  communityName: mappedCommunities[index]['communityName'],
                  communityDescription: mappedCommunities[index]['communityInfo'],
                  communityIcon: mappedCommunities[index]['communityProfilePic'],
                  membersCount: mappedCommunities[index]['membersCount'] < 1000 ?
                        mappedCommunities[index]['membersCount'].toString() 
                        : '${(mappedCommunities[index]['membersCount']/100).truncateToDouble() /10.0}k',
                  isFollowing: mappedCommunities[index]['isFollowing'],      
                  );
              }
            ),
          ],
        ), 
      );
    }
  }
}
