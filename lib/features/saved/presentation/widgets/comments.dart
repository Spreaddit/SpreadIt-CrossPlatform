import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import '../../../generic_widgets/bottom_model_sheet.dart';
import '../../data/comment.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final bool saved;

  CommentWidget({
    required this.comment,
    this.saved = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white, // Set background color to white
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: saved ? Colors.grey[200]! : Colors.grey,
                  width: saved ? screenHeight * 0.01 : screenHeight * 0.001,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.postTitle,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    if (saved)
                      Text(
                        '${comment.username!} • ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    Text(
                      '${comment.communityTitle} • ${comment.time}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    if (!saved)
                      Row(
                        children: [
                          Text(
                            '• ${comment.votes} ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Image.asset(
                            "assets/images/upvoteicon.png",
                            height: screenHeight * 0.015,
                            color: Colors.grey,
                          ),
                        ],
                      )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          if (saved)
            CommentFooter(
              onMorePressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomBottomSheet(icons: [
                      Icons.share,
                      Icons.bookmarks_outlined,
                      CupertinoIcons.bell_solid
                    ], text: [
                      'Share',
                      'Unsave',
                      'Get reply notifications'
                    ], onPressedList: [
                      () => {},
                      () => {},
                      () => {}
                    ]);
                  },
                );
              },
              onReplyPressed: () {},
              number: comment.votes,
              upvoted: false,
              downvoted: false,
            ),
        ],
      ),
    );
  }
}
