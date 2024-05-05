import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/people_elemet.dart';


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
    users = await getSearchResults(widget.searchItem, 'people','relevance');
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
                );
              }
            ),
          ],
        ), 
      );
    }
  }
}

