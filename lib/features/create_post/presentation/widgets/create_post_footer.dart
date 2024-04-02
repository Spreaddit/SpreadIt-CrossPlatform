import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostFooter extends StatefulWidget {
  final VoidCallback toggleFooter;

  const PostFooter({
    required this.toggleFooter,
  });

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.attachment_rounded,
                size: 25
                ),
              onPressed: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.photo,
                size: 25
                ),
              onPressed: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.ondemand_video_rounded,
                size: 25
                ),
              onPressed: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.poll,
                size: 25
                ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              height: 25,
              width: 25,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 25
                  ),
                onPressed: widget.toggleFooter,
              ),
            ),
          ),
        ],
        ),
    );
  }
}

/* TODO
1) el action bta3 kol icon
2) el api bta3 el actions di */