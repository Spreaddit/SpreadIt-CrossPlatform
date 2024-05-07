import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_post_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/delete_post.dart';

class ScheduledPostCard extends StatelessWidget {
  final String username;
  final String title;
  final String content;
  final DateTime dateAndTime;
  final String id;
  final Function refreshScheduledPosts;
  final String communityName;

  ScheduledPostCard({
    required this.username,
    required this.title,
    required this.content,
    required this.dateAndTime,
    required this.id,
    required this.refreshScheduledPosts,
    required this.communityName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                  Text(
                    ' Scheduled ${DateFormat('M/d').format(dateAndTime)} @ ${DateFormat('h:mm a').format(dateAndTime)} Africa/Cairo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 1,
              ),
              SizedBox(height: 8),
              Text('u/$username'),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(content),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Edit Post'),
                    onPressed: () {
                      //navigate to edit post page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPost(
                            communityName: communityName,
                            postId: id,
                            postContent: content,
                            onContentChanged: (String newContent) {},
                          ),
                        ),
                      ).then((_) {
                        //refresh scheduled posts
                        refreshScheduledPosts.call();
                      });
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete Post'),
                    onPressed: () async {
                      int response = await deletePost(id);
                      if (response == 200) {
                        CustomSnackbar(
                                content: 'Your post is deleted successfully')
                            .show(context);
                        refreshScheduledPosts.call();
                      } else if (response == 500) {
                        CustomSnackbar(
                                content:
                                    'Internal server error, try again later')
                            .show(context);
                      } else {
                        CustomSnackbar(content: 'Post not found').show(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
