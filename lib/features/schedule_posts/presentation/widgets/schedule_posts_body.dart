import 'package:flutter/material.dart';
import './scheduled_post_card.dart';

class ScheduledPostsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        children: <Widget>[
          SizedBox(height: 4),
          Text(
            "    SCHEDULED POSTS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey[600]),
          ),
          SizedBox(height: 4),
          ScheduledPostCard(
            date: '2022-01-01',
            time: '12:00 am',
            username: 'username',
            title: 'Title',
            content: 'Content',
          ),
          ScheduledPostCard(
            date: '2022-01-01',
            time: '12:15 am',
            username: 'username',
            title: 'Title',
            content: 'Content',
          ),
        ],
      ),
    );
  }
}
