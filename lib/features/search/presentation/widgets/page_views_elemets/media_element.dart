import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MediaElement extends StatefulWidget {

  final String username;
  final String userIcon;
  final String postTitle;
  final String media;

  const MediaElement({
    required this.username,
    required this.userIcon,
    required this.postTitle,
    required this.media,

  });

  @override
  State<MediaElement> createState() => _MediaElementState();
}

class _MediaElementState extends State<MediaElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage(widget.media),
              height: 200,
              width: 170,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 5, 2),
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.userIcon),
                  radius: 10,
                ),
              ),
              Text(
                widget.username,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            widget.postTitle,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}