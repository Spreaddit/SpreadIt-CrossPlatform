import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// This widget is to display the user information in the page. It displays the user avatar, his email and username.


class UserCard extends StatelessWidget {

  final String username;
  final String email;
  final Image userProfilePic;

  const UserCard({
    required this.username,
    required this.email,
    required this.userProfilePic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height:80,
            width:80,
            child: userProfilePic, 
            ), 
          Column(
            children: [
              Text(username),  
              Text(email), 
            ],)
        ],),
    );
  }
}