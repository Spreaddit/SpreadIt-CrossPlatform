import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/data/uodate_edited_comment.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/data/update_edited_post.dart';

import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_footer.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_header.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_body.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';

class EditComment extends StatefulWidget {
  EditComment();

  @override
  State<EditComment> createState() {
    return _EditCommentState();
  }
}

class _EditCommentState extends State<EditComment> {
  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();
  Comment? comment;
  String? content;
  bool isEnabled = true;
  void setContent(String? C) {
    content = comment!.content;
  }

  @override
  void initState() {
    setContent(content);
    super.initState();
  }

  bool validateContent(String value) {
    if (value.isNotEmpty && !RegExp(r'^[\W_]+$').hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  void updateContent(String value) {
    setState(() {
      content = value; // Update content when text changes
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (_finalContentForm.currentState != null) {
          _finalContentForm.currentState!.save();
        }
      });
      isEnabled = validateContent(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    comment = args['comment'];

    return Scaffold(
        appBar: AppBar(
          title: GenericHeader(
            buttonText: "Save",
            onPressed: () async {
              print("pressed");
              comment!.content = content!;
              await updateEditedComment(
                  commentId: comment!.id, content: content);
              print("this is the content${comment!.content}");
              print("content before fetching$content");
              //navigate to post card page with edited comment
            },
            isEnabled: isEnabled,
            onIconPress: () {}, //navigate to pst card page
            showHeaderTitle: true,
          ),
        ),
        body: Column(
          children: [
            GenericContent(
                initialBody: comment!.content,
                bodyHint: "Add a comment",
                formKey: _finalContentForm,
                onChanged: updateContent),
            GenericFooter(
              toggleFooter: null,
              showAttachmentIon: true,
              showPhotoIcon: false,
              showVideoIcon: false,
              showPollIcon: false,
            )
          ],
        ));
  }
}
