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

/// Widget for editing a comment.
class EditComment extends StatefulWidget {
  /// The comment to be edited.
  Comment? comment;
  final void Function(String)? onContentChanged;

  /// Constructor for EditComment widget.
  EditComment({this.comment, this.onContentChanged});
  @override
  State<EditComment> createState() {
    return _EditCommentState();
  }
}

class _EditCommentState extends State<EditComment> {
  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();

  String? content;
  bool isEnabled = true;
  void setContent(String? C) {
    content = widget.comment!.content;
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
    return Scaffold(
        appBar: AppBar(
          title: GenericHeader(
            buttonText: "Save",
            onPressed: () async {
              print("pressed");
              widget.comment!.content = content!;
              widget.onContentChanged!(content!);
              await updateEditedComment(
                  commentId: widget.comment!.id, content: content);
              print("this is the content${widget.comment!.content}");
              print("content before fetching$content");
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            isEnabled: isEnabled,
            onIconPress: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            showHeaderTitle: true,
          ),
        ),
        body: Column(
          children: [
            GenericContent(
                initialBody: widget.comment!.content,
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
