import 'package:flutter/material.dart';

class PostFooter extends StatefulWidget {
  const PostFooter({Key? key}) : super(key: key);

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 20,
          width: 20,
          child: IconButton(
            icon: Icon(
              Icons.attachment_rounded,
              size: 20
              ),
            onPressed: () {},
          ),
        ),
        Container(
          height: 20,
          width: 20,
          child: IconButton(
            icon: Icon(
              Icons.photo,
              size: 20
              ),
            onPressed: () {},
          ),
        ),
        Container(
          height: 20,
          width: 20,
          child: IconButton(
            icon: Icon(
              Icons.video_chat,
              size: 20
              ),
            onPressed: () {},
          ),
        ),
        Container(
          height: 20,
          width: 20,
          child: IconButton(
            icon: Icon(
              Icons.poll,
              size: 20
              ),
            onPressed: () {},
          ),
        ),

      ],);
  }
}