import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/class_models/followers_class_model.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/followers_tile.dart';

/// A page widget to display a list of followers.
///
/// This widget displays a list of followers with their usernames and avatars.
/// It provides a search functionality to filter followers.
///
/// Example usage:
/// ```dart
/// Navigator.of(context)
///     .pushNamed('/followers-page', arguments: {
///      'followers': followerslist,
/// });
/// ```
/// 
class FollowUsersPage extends StatefulWidget {
  @override
  _FollowUsersPageState createState() => _FollowUsersPageState();
}

class _FollowUsersPageState extends State<FollowUsersPage> {
  List<FollowUser> followerslist = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    followerslist = args?['followers'] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
      body: followerslist.isEmpty
          ? Center(
              child: Text("No followers"),
            )
          : Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                        "This list of followers is only visible to you. The most recent followers are shown first"),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: followerslist.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FollowerListTile(
                            username: followerslist[index].username,
                            avatarUrl: followerslist[index].avatar,
                            isFollowed: followerslist[index].isFollowed,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.transparent,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
