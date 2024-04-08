import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({Key? key}) : super(key: key);
  @override
  State<AddCommentWidget> createState() {
    return _AddCommentWidgetState();
  }
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  TextEditingController commentController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  ScrollController _scrollController = ScrollController();

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
                  controller: commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Link name',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                    labelText: 'https://',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String linkName = '[${commentController.text}]';
                    String link = '(${linkController.text})';
                    String finalLink = '$linkName $link';

                    commentController.text = finalLink;

                    linkController.clear();
                    Navigator.pop(context);
                    /*_scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );*/
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
          controller: _scrollController, // Assign scroll controller
          child: TextFormField(
            controller: commentController,
            maxLines: null,
            decoration: InputDecoration(
              labelText: "Add a comment",
              suffixIcon: IconButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: Icon(Icons.link),
              ),
            ),
          ),
        ),
      ),
      trailing: OutlinedButton(
        onPressed: () {
          print('add comment');
          FocusScope.of(context).unfocus();
        },
        child: Text("Post"),
      ),
    );
  }
}
