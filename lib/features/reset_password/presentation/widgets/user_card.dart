import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/user.dart';
import 'package:spreadit_crossplatform/user_info.dart';


/// This widget is to display the user information in the page. It displays the user avatar, his email and username.


final String username = UserSingleton().user!.username;
final String email = UserSingleton().user!.email!;
final String image = UserSingleton().user!.avatarUrl!;

class UserCard extends StatelessWidget {

  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height:80,
            width:80,
            child: Image.asset(image),
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