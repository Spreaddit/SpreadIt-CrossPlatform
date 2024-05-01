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
    users = await getSearchResults(widget.searchItem, 'users','relevance');
    mappedUsers = extractUsersDetails(users);
    setState(() {});
  }

  List<Map<String, dynamic>> extractUsersDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedUsers = [];
    for (var user in results) {
      mappedUsers.add({
        'username': user['username'],
        'userProfilePic': user['userProfilePic'],
      });
    }
    return mappedUsers;
  }

  @override
  Widget build(BuildContext context) {
    if (mappedUsers.isEmpty) {
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
              itemCount: mappedUsers.length,
              itemBuilder: (context, index) {
                return PeopleElement(
                  username: mappedUsers[index]['username'],
                  userIcon: mappedUsers[index]['userProfilePic'],
                );
              }
            ),
          ],
        ), 
      );
    }
  }
}

/* TO DOS :
1) akhod boolean el user da followed walla laa w 3ala asaso ba-render el button
 */