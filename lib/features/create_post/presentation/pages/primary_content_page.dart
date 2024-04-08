import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../widgets/header_and_footer_widgets/create_post_header.dart';
import '../widgets/title.dart';
import '../widgets/content.dart';
import '../widgets/header_and_footer_widgets/create_post_footer.dart';
import '../widgets/header_and_footer_widgets/create_post_secondary_footer.dart';
import '../../../generic_widgets/validations.dart';
import '../widgets/show_discard_bottomsheet.dart';
import '../widgets/photo_and_video_pickers/image_picker.dart';
import '../widgets/photo_and_video_pickers/video_picker.dart';
import '../widgets/poll_widgets/poll.dart';
import '../widgets/link.dart';

class CreatePost extends StatefulWidget {  
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final GlobalKey<FormState> _primaryTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _primaryContentForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _primaryLinkForm = GlobalKey<FormState>();

  String title = '';
  String content = '';

  bool isPrimaryFooterVisible = true;
  bool isButtonEnabled = false;
  bool isPollOptionValid = false;
  bool createPoll = false;
  bool isLinkAdded = false;

  File? image;
  File? video;
  String? link;
  IconData? lastPressedIcon;

  void updateTitle(String value) {
    title = value;
    _primaryTitleForm.currentState!.save();
    updateButtonState();
  }

  void updateContent(String value) {
    content = value;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
    if (_primaryContentForm.currentState != null) {
      _primaryContentForm.currentState!.save();
    }
    });
  }

  void updateLink(String value) {
    link = value;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
    if (_primaryLinkForm.currentState != null) {
      _primaryLinkForm.currentState!.save();
    }
    });
  }

  void updateButtonState() {
    if (link == null) {
      setState(() {
        isButtonEnabled = validatePostTitle(title);
      });
    }
    else {
      isButtonEnabled = validatePostTitle(title);  // TODO : add check link validity
    }
  }

  void setLastPressedIcon(IconData? passedIcon) {
    setState(() {
      lastPressedIcon = passedIcon;
    });
  }

  void toggleFooter() {
    setState(() {
      isPrimaryFooterVisible = !isPrimaryFooterVisible;
    });
  }

  void addLink() {
    setState(() {
      isLinkAdded = !isLinkAdded;
      print(isLinkAdded);
    });
    if (isLinkAdded) {
      setLastPressedIcon(Icons.attachment_rounded);
    }
    else {
      setLastPressedIcon(null);
    }
  }

  Future<void> pickImage() async {
    final image = await pickImageFromFilePicker();
    setState(() {
      this.image = image;
    });
  }

  Future<void> pickVideo() async {
    final video = await pickVideoFromFilePicker();
    setState(() {
      this.video = video;
    });
  }

  void openPollWidow() {
    setState(() {
      createPoll = !createPoll;
    });
  }

  void navigateToPostToCommunity() {
    Navigator.of(context).pushNamed('/post-to-community', arguments: {
      'title': title,
      'content': content,
      'link': link,
      'image': image,
      'video':video,
      'isLinkAdded':isLinkAdded,
      }
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CreatePostHeader(
                  buttonText: "Next",
                  onPressed: navigateToPostToCommunity,
                  isEnabled: isButtonEnabled,
                  onIconPress: validatePostTitle(title) ? () {}: () {showDiscardButtomSheet(context);},
                ),
                PostTitle(
                  formKey: _primaryTitleForm,
                  onChanged:updateTitle,
                  initialBody: '',
                ),
                if (image != null)
                   Container(
                    alignment: Alignment.center,
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(image!),
                          fit:BoxFit.cover,
                        ),
                    ),
                  ),
                if (video != null)
                   Container(
                    alignment: Alignment.center,
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(video!),
                          fit:BoxFit.cover,
                        ),
                    ),
                  ), 
                if (isLinkAdded)
                   LinkTextField(
                    formKey: _primaryLinkForm,
                    onChanged: updateLink,
                    hintText: 'URL',
                    initialBody: '',
                    onIconPress: addLink,
                ),    
                PostContent(
                  formKey: _primaryContentForm,
                  onChanged:updateContent,
                  hintText: 'body text (optional)',
                  initialBody: '',
                ),
                if (createPoll)
                  Poll(
                    onPollCancel: openPollWidow,
                    setLastPressedIcon: setLastPressedIcon,
                  ),
              ],
            ),     
          ), 
          isPrimaryFooterVisible? PostFooter(
            toggleFooter: toggleFooter,
            showAttachmentIcon: true,
            showPhotoIcon: true,
            showVideoIcon: true,
            showPollIcon: true,
            onLinkPress: addLink,
            onImagePress: pickImage,
            onVideoPress: pickVideo,
            onPollPress: openPollWidow,
            lastPressedIcon: lastPressedIcon, 
            setLastPressedIcon: setLastPressedIcon,
            ) : SecondaryPostFooter(
              onLinkPress: addLink,
              onImagePress: pickImage,
              onVideoPress: pickVideo,
              onPollPress: openPollWidow,
              lastPressedIcon: lastPressedIcon, 
              setLastPressedIcon: setLastPressedIcon,
            ),
        ],
      ),
    );
  }
}

/* TODOs 
1) a7ot cancel icon 3al sowar wel video when uploaded
2) ashouf el video msh shaghal leih
3) ab3at el haga di kollaha lel final content page (almost done)
5) unit testing 
 */