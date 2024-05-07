import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/data/update_edited_post.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_footer.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_header.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/widgets/generic_body.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/user_info.dart';

class EditPost extends StatefulWidget {
  String postId;
  String postContent;
  final void Function(String) onContentChanged;
  final String communityName;

  EditPost({
    required this.postId,
    this.postContent = "",
    required this.onContentChanged,
    required this.communityName,
  });

  @override
  State<EditPost> createState() {
    return _EditPostState();
  }
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();
  bool isNotApprovedForPostEdit = false;

  String? content;
  bool isEnabled = true;
  void setContent(String? C) {
    content = widget.postContent;
  }

  @override
  void initState() {
    setContent(content);
    super.initState();
    checkIfCanEditPost();
  }

  /// [checkIfCanEditPost] : a function used to check if users aren't approved for editing post in the community

  void checkIfCanEditPost() async {
    await checkIfNotApproved(
            widget.communityName, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForPostEdit = value;
    });
    setState(() {
      //TODO: check if this causes exception
      isNotApprovedForPostEdit = isNotApprovedForPostEdit;
    });
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
              if (isNotApprovedForPostEdit) {
                CustomSnackbar(
                        content:
                            "You are not approved to edit the post in this community")
                    .show(context);
                return;
              }
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
