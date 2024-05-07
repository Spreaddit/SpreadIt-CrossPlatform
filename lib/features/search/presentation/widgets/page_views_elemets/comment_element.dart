import 'package:flutter/material.dart';

/// This is the customized widget for displaying the comments search result.
/// Parameters :
/// 1) [communityIcon] : the icon of the community to which the post was made.
/// 2) [communityName] : the name of the community to which to post was made.
/// 3) [commentorName] : the name of the commentor on the post.
/// 4) [commentorIcon] : the icon of the commentor on the post.
/// 5) [postTitle] : the title of the created post.
/// 6) [comment] : the comment content.
/// 7) [commentUpvotes] : number of comment upvotes.
/// 8) [postUpvotes] : number of post upvotes.
/// 9) [commentsCount] : number of commnets on the post.

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
                  backgroundImage: NetworkImage(widget.communityIcon),
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
                      backgroundImage: NetworkImage(widget.commentorIcon),
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