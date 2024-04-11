import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/update_comments_list.dart';

class AddReplyWidget extends StatefulWidget {
  String parentCommentId;
  final Function(Comment) addReply;
  AddReplyWidget({required this.parentCommentId, required this.addReply});
  @override
  State<AddReplyWidget> createState() {
    return _AddReplyWidgetState();
  }

  // Function to get the text from the input field
  String getCommentText() {
    return _AddReplyWidgetState()._commentController.text;
  }
}

class _AddReplyWidgetState extends State<AddReplyWidget> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Link name',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _linkController,
                  decoration: InputDecoration(
                    labelText: 'https://',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String linkName = '[${_commentController.text}]';
                    String link = '(${_linkController.text})';
                    String finalLink = '$linkName $link';

                    _commentController.text = finalLink;

                    _linkController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add link'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Expanded(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: TextFormField(
            controller: _commentController,
            maxLines: null,
            decoration: InputDecoration(
              labelText: "Add a comment",
              suffixIcon: IconButton(
                onPressed: () {
                  // _showBottomSheet(context);
                },
                icon: Icon(Icons.link),
              ),
            ),
          ),
        ),
      ),
      trailing: OutlinedButton(
        onPressed: () async {
          print('add reply');
          FocusScope.of(context).unfocus();
          String newReply = _commentController.text;
          Comment? nReply = await updateComments(
              id: widget.parentCommentId, content: newReply, type: 'reply');
          setState(() {
            widget.addReply(nReply!);
            print('nReply ${nReply.content}');
          });
        },
        child: Text("Reply"),
      ),
    );
  }
}
