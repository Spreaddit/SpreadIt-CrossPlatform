import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/create_post_header.dart';
import '../widgets/title.dart';
import '../widgets/content.dart';
import '../widgets/create_post_footer.dart';
import '../widgets/create_post_secondary_footer.dart';
import '../../../generic_widgets/validations.dart';
import '../widgets/showDiscardBottomSheet.dart';

class CreatePost extends StatefulWidget {  
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final GlobalKey<FormState> _primaryTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _primaryContentForm = GlobalKey<FormState>();

  String title = '';
  String content = '';

  bool isPrimaryFooterVisible = true;
  bool isButtonEnabled = false;

  void updateTitle(String value) {
    print('title :' + title);
    title = value;
    print('title after initialization :' + title);
    _primaryTitleForm.currentState!.save();
    print('title state saved');
    updateButtonState();
  }

  void updateContent(String value) {
    print('content :' + content);
    content = value;
    print('content after initialization :' + content);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
    if (_primaryContentForm.currentState != null) {
      _primaryContentForm.currentState!.save();
      print('content state saved');
    }
    });
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = validatePostTitle(title);
    });
  }

  void toggleFooter() {
    setState(() {
      isPrimaryFooterVisible = !isPrimaryFooterVisible;
    });
  }

  void navigateToPostToCommunity() {
      Navigator.of(context).pushNamed('/post-to-community');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: CreatePostHeader(
              buttonText: "Next",
              onPressed: navigateToPostToCommunity,
              isEnabled: isButtonEnabled,
              onIconPress: validatePostTitle(title) ? () {}: () {showDiscardButtomSheet(context);},
              ),
          ),
          PostTitle(
            formKey: _primaryTitleForm,
            onChanged:updateTitle,
          ),
          PostContent(
            formKey: _primaryContentForm,
            onChanged:updateContent,
            hintText: 'body text (optional)',
            initialBody: '',
          ),
          Container(
            child: CreatePostHeader(
              buttonText: "Next",
              onPressed: navigateToPostToCommunity,
              isEnabled: isButtonEnabled,
              onIconPress: validatePostTitle(title) ? () {}: () {showDiscardButtomSheet(context);},
              ),
          ),
          isPrimaryFooterVisible? PostFooter(
            toggleFooter: toggleFooter,
            showAttachmentIcon: true,
            showPhotoIcon: true,
            showVideoIcon: true,
            showPollIcon: true,
            ) : SecondaryPostFooter(),
        ],)
    );
  }
}

/* TODOs 
1) asalla7 moshekelt el content initstate walla ma3rafsh eih  
3) a7ot actions lel footer
4) law 3andi link a7ottelo makano bardou
5) ab3at el haga di kollaha lel final content page 
6) navigations
7) unit testing 
 */