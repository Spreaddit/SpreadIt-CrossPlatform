import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';

class Comment {
  final int commentId;
  final String userId;
  final String postId;
  final String username;
  final String profilePic;
  final int votesCount;
  final DateTime date;
  final String content;

  Comment({
    required this.commentId,
    required this.userId,
    required this.postId,
    required this.username,
    required this.profilePic,
    required this.votesCount,
    required this.date,
    required this.content,
  });
}

class _CommentHeader extends HookWidget {
  final String username;
  final String userId;
  final String postId;
  final DateTime date;
  final String profilePic;

  _CommentHeader({
    required this.username,
    required this.userId,
    required this.postId,
    required this.date,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    final sec30PassedToggler =
        useState(false); //used for changing time without constant re-render
    final dateFormatted = useState(dateToDuration(date));

    useEffect(() {
      dateFormatted.value = dateToDuration(date);
      print(dateFormatted.value);
      return;
    }, [sec30PassedToggler.value]);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 30), (timer) {
        sec30PassedToggler.value = !sec30PassedToggler.value;
      });

      return timer.cancel;
    }, []);

    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 20),
          title: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(dateFormatted.value),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  final Comment comment;
  CommentCard({required this.comment});
  @override
  State<CommentCard> createState() {
    return _CommentCardState();
  }
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentHeader(
            username: widget.comment.username,
            userId: widget.comment.userId,
            postId: widget.comment.postId,
            date: widget.comment.date,
            profilePic: widget.comment.profilePic,
          ),
          Text(
            widget.comment.content,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          CommentFooter(
            onMorePressed: () => {},
            onReplyPressed: () => {},
            number: widget.comment.votesCount,
            upvoted: false,
            downvoted: false,
          ),
        ],
      ),
    );
  }
}
