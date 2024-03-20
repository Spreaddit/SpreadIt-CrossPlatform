import 'package:flutter/material.dart';

//TODO: create options tab for post (shows join community options when pressed)

// class PostOptions extends StatefulWidget {
// bool isJoinCommunityVisible;
// }
class _PostHeader extends StatelessWidget {
  final String username;
  final String userId;
  final DateTime date;
  //TODO:final PostOptions options;

  _PostHeader({
    required this.username,
    required this.userId,
    required this.date,
    //TODO:required this.options,
  });

  @override
  Widget build(BuildContext) {
    return Row(
        //TODO: Styling
        );
  }
}

class _PostBody extends StatelessWidget {
  final String headline;
  final String description;

  _PostBody({
    required this.headline,
    required this.description,
  });

  @override
  Widget build(BuildContext) {
    return Row(
        //TODO: Styling
        );
  }
}

class _PostInteractions extends StatefulWidget {
  final int votesCount;
  final int sharesCount;
  final int commentsCount;
  //TODO:final bool isJoinCommunityVisible;

  _PostInteractions({
    required this.votesCount,
    required this.sharesCount,
    required this.commentsCount,
    //TODO:required this.isJoinCommunityVisible,
  });

  _PostInteractionsState createState() => _PostInteractionsState();
}

class _PostInteractionsState extends State<_PostInteractions> {
  Widget build(BuildContext) {
    return Row(
        //TODO: Styling + state change when liking/sharing/etc
        );
  }
}

class Post extends StatelessWidget {
  final int postId;
  final String username;
  final String userId;
  final DateTime date;
  final String headline;
  final String description;
  final int votesCount;
  final int sharesCount;
  final int commentsCount;
  //TODO: final bool isJoinCommunityVisible;

  Post({
    required this.postId,
    required this.username,
    required this.userId,
    required this.date,
    required this.headline,
    required this.description,
    required this.votesCount,
    required this.sharesCount,
    required this.commentsCount,
    //TODO:required this.isJoinCommunityVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostHeader(
          username: username,
          userId: userId,
          date: date,
        ),
        _PostBody(
          headline: headline,
          description: description,
        ),
        _PostInteractions(
          votesCount: votesCount,
          sharesCount: sharesCount,
          commentsCount: commentsCount,
        )
      ],
    );
  }
}
