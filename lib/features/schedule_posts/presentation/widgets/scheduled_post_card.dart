import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduledPostCard extends StatelessWidget {
  final String username;
  final String title;
  final String content;
  final DateTime dateAndTime;
  final String id;

  ScheduledPostCard({
    required this.username,
    required this.title,
    required this.content,
    required this.dateAndTime,
    required this.id,
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
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete Post'),
                    onPressed: () {
                      //delete post
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
