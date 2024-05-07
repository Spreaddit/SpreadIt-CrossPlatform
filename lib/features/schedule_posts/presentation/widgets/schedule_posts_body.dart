import 'package:flutter/material.dart';
import './scheduled_post_card.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/schedule_posts/data/get_scheduled_posts_service.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';

class ScheduledPostsBody extends StatelessWidget {
  final String subspreaditName;
  final Community community;
  final Function refreshScheduledPosts;

  ScheduledPostsBody({
    required this.subspreaditName,
    required this.community,
    required this.refreshScheduledPosts,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: GetScheduledPostsService()
          .getScheduledPosts(subspreaditName: subspreaditName),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.schedule,
                size: 35,
                color: const Color.fromARGB(255, 92, 92, 92),
              ),
              Text(
                'There aren\'t any scheduled posts in',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 92, 92, 92),
                ),
              ),
              Text(
                'in r/${community.name} yet.',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 92, 92, 92),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalCreatePost(
                          title: '',
                          content: '',
                          community: [community],
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Color.fromARGB(255, 6, 107, 190),
                  ),
                  child: Text(
                    'Schedule Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ));
        } else {
          return Container(
            color: Colors.grey[200],
            child: ListView(
              children: snapshot.data!.map((Post post) {
                return ScheduledPostCard(
                  id: post.postId,
                  refreshScheduledPosts: refreshScheduledPosts,
                  dateAndTime: post.date.add(Duration(hours: 3)),
                  username: post.username,
                  title: post.title!,
                  communityName: post.community,
                  content: post.content?.last ?? '',
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
