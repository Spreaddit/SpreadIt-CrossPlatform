import 'package:flutter/material.dart';

class PostTitle extends StatefulWidget {
  const PostTitle({Key? key}) : super(key: key);

  @override
  State<PostTitle> createState() => _PostTitleState();
}

class _PostTitleState extends State<PostTitle> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
        children:[Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child:SingleChildScrollView(
            child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
                ),
            ),
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
        ),
        ],
        );
  }
}

/*
TODOs:
1) ashouf 7war el kalam el underlined da 
2) a7ot el controller wel kalam da
*/