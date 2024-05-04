import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/follow_unfollow_api.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

class PeopleElement extends StatefulWidget {

  final String username;
  final String userIcon;
  final String followersCount;
  final bool isFollowing;

  const PeopleElement({
    required this.username,
    required this.userIcon,
    required this.followersCount,
    required this.isFollowing,
  });

  @override
  State<PeopleElement> createState() => _PeopleElementState();
}

class _PeopleElementState extends State<PeopleElement> {

  void followUser() async {
    await toggleFollow(username: widget.username, isFollowing: widget.isFollowing);
    setState((){});
  }

  void navigateToUserProfile() {
    Navigator.of(context).push(
                MaterialPageRoute(
                  settings: RouteSettings(
                    name: '/user-profile/${widget.username}',
                  ),
                  builder: (context) => UserProfile(
                    username: widget.username,
                  ),
                ),
              ),
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          Row(
            children:[
              InkWell(
                onTap: navigateToUserProfile , // navigate to user profile
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.userIcon),
                        radius: 17,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.followersCount} followers',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(), 
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: ElevatedButton(
                    onPressed: followUser,  
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.blue[900]!),
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                      backgroundColor:widget.isFollowing? Colors.white : Colors.blue[900],
                      fixedSize: Size(15,7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ), 
                    ), 
                    child: Text(
                      widget.isFollowing ? 'Unfollow' : 'Follow',
                      style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color:widget.isFollowing ? Colors.blue[900] : Colors.white,
                      ),
                    ),
                  ),
                ), 
            ],
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),      
        ],
      ),
    );
  }
}