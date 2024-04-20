import 'package:flutter/material.dart';

class CommentElement extends StatefulWidget {

  final String communityName;
  final String communityIcon;
  final String commentorName;
  final String commentorIcon;
  final String postTitle;
  final String comment;
  final String commentUpvotes;
  final String postUpvotes;
  final String commentsCount;

  const CommentElement({
    required this.communityName,
    required this.communityIcon,
    required this.commentorName,
    required this.commentorIcon,
    required this.postTitle,
    required this.comment,
    required this.commentUpvotes,
    required this.postUpvotes,
    required this.commentsCount,
  });

  @override
  State<CommentElement> createState() => _CommentElementState();
}

class _CommentElementState extends State<CommentElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      alignment: Alignment.centerLeft,
      child: Column(
        children : [
          Row(
            children: [
              Padding(
                padding : EdgeInsets.only(right: 5),
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.communityIcon),
                  radius: 13,
                ),
              ),
              Text(
                widget.communityName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(3),
            child: Text(
                widget.postTitle,
                style: TextStyle(
                  fontSize: 15,
                ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      CircleAvatar(
                      backgroundImage: AssetImage(widget.commentorIcon),
                      radius: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          widget.commentorName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        widget.comment,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${widget.commentUpvotes} upvotes'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {}, // go to comments
              child: Text(
                'Go to Comments',
                style: TextStyle(
                  color: Colors.blue[900],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('${widget.postUpvotes} upvotes . ${widget.commentsCount} comments'),
          ),
          Divider(
            color: Colors. grey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}