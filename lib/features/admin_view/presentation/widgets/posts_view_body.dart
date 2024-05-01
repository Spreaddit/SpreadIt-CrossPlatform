import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_caard.dart';

class PostsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = ['Post 1', 'Post 2', 'Post 3'];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: PostCard(
          post: Post(
            postId: '1',
            userId: '1',
            username: 'username',
            userProfilePic: 'userProfilePic',
            votesUpCount: 1,
            votesDownCount: 1,
            sharesCount: 1,
            commentsCount: 1,
            numberOfViews: 1,
            date: DateTime.now(),
            title: 'title',
            content: ['content'],
            community: 'community',
            type: 'type',
            pollOptions: [],
            pollVotingLength: 'pollVotingLength',
            pollExpiration: DateTime.now(),
            isPollEnabled: true,
            link: 'link',
            attachments: [],
            comments: [],
            hiddenBy: [],
            votedUsers: [],
            isSpoiler: true,
            isCommentsLocked: true,
            isNsfw: true,
            sendPostReplyNotification: true,
            isSaved: true,
          ),
          comments: [],
          isUserProfile: false,
        ));
      },
    );
  }
}
