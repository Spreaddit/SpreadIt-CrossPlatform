import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/data/update_edited_post.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_footer.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_header.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_body.dart';

class EditPost extends StatefulWidget {
  String postId;
  String postContent;
  final void Function(String) onContentChanged;

  EditPost({
    required this.postId,
    this.postContent = "",
    required this.onContentChanged,
  });

  @override
  State<EditPost> createState() {
    return _EditPostState();
  }
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();

  String? content;
  bool isEnabled = true;
  void setContent(String? C) {
    content = widget.postContent;
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
          automaticallyImplyLeading: false,
          title: GenericHeader(
            buttonText: "Save",
            onPressed: () async {
              print("pressed");
              widget.postContent = content!;
              widget.onContentChanged(content!);
              await updateEditedPost(content: content, postId: widget.postId);
              print("this is the content${widget.postContent}");
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
              initialBody: widget.postContent,
              bodyHint: "Add a post",
              formKey: _finalContentForm,
              onChanged: updateContent,
            ),
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
