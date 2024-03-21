import 'package:flutter/material.dart';

//TODO: change to render different bars when in different
//tabs(e.g., home, community, chat, etc)
class TopBar extends AppBar {
  TopBar()
      : super(
          toolbarHeight: 60,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(18, 0, 0, 0),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
              children: [
                Text("Home"),
                IconButton(
                  onPressed:
                      () {}, //TODO: implement different categories of posts
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        );
}
