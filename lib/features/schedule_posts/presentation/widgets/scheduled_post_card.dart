import 'package:flutter/material.dart';

class ScheduledPostCard extends StatelessWidget {
  final String date;
  final String username;
  final String title;
  final String content;
  final String time;

  ScheduledPostCard({
    required this.date,
    required this.time,
    required this.username,
    required this.title,
    required this.content,
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
                    ' Scheduled $date @ $time Africa/Cairo',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    onPressed: () {},
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete Post'),
                    onPressed: () {},
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
