import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/people_elemet.dart';

/// Responsible for displaying the search results for user profiles.
/// The class also displays a list of [PeopleElement] widgets, which is a Custom widget to display the user profiles.
/// The class handles the logic of tapping a user profile search result, which is navigating to the corresponding user profile.
/// The class also handles the logic of pressing the 'Follow/Unfollow' button by toggling the following state.


class PeoplePageView extends StatefulWidget {
  final String searchItem;
  const PeoplePageView({Key? key, required this.searchItem}) : super(key: key);

  @override
  State<PeoplePageView> createState() => _PeoplePageViewState();
}

class _PeoplePageViewState extends State<PeoplePageView> {

  Map<String,dynamic> users = {};
  List<Map<String, dynamic>> mappedUsers = [];
  
  @override
  void initState() {
    super.initState();
    getUsersResults();
  }

  void getUsersResults() async {
    users = await GetSearchResults().getSearchResults(widget.searchItem, 'people','relevance');
    mappedUsers = extractUsersDetails(users);
    setState(() {});
  }

  List<Map<String, dynamic>> extractUsersDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedUsers = [];
    try {
      for (var user in results) {
        mappedUsers.add({
          'userId': user['userId'] ?? (throw Exception('null')),
          'username': user['username'] ?? (throw Exception('null')),
          'userProfilePic': user['userProfilePic'] ?? (throw Exception('null')),
          'followersCount': user['followersCount'] ?? (throw Exception('null')),
          'isFollowing': user['isFollowing'] ?? (throw Exception('null')),
        });
      }
      return mappedUsers;
    }
    catch(e) {
      return [];
    }
  }

  void toggleIsFollowing (bool isFollowing) {
    setState(() => isFollowing = !isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF4500),
          ),
        ),
      );
    }
    if (mappedUsers.isEmpty) {
      return Image.asset('./assets/images/Empty_Toast.png');
    }
    else{  
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(top:3),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mappedUsers.length,
              itemBuilder: (context, index) {
                return PeopleElement(
                  username: mappedUsers[index]['username'],
                  userIcon: mappedUsers[index]['userProfilePic'],
                  followersCount: mappedUsers[index]['followersCount'] < 1000 ?
                        mappedUsers[index]['followersCount'].toString() 
                        : '${(mappedUsers[index]['followersCount']/100).truncateToDouble() /10.0}k',
                  isFollowing: mappedUsers[index]['isFollowing'],
                  toggleIsFollowing: () => toggleIsFollowing(mappedUsers[index]['isFollowing']),
                );
              }
            ),
          ],
        ), 
      );
    }
  }
}

