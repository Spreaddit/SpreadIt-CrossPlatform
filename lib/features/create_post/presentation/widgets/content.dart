import 'package:flutter/material.dart';

class PostContent extends StatefulWidget {
  const PostContent({Key? key}) : super(key: key);

  @override
  State<PostContent> createState() => _PostcontentState();
}

class _PostcontentState extends State<PostContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
          child:SingleChildScrollView(
            child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'body text (optional)',
              hintStyle: TextStyle(
                fontSize: 20,
                ),
            ),
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 15,
            ),
            ),
          ),
        ),
        );
  }
}

/*
TODOs:
1) ashouf 7war el kalam el underlined da 
2) a7ot el controller wel kalam da
*/