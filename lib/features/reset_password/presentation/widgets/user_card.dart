import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// This widget is to display the user information in the page. It displays the user avatar, his email and username.

// TODO : to be parametrised in phase 2

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
            child: Image.asset("./assets/images/UserAvatar.png") // taken from user
            ), 
          Column(
            children: [
              Text("u/username"),  // to be taken from the backend
              Text("jshd@sf.com"), // to be taken from the backend
            ],)
        ],),
    );
  }
}