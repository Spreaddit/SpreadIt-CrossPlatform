import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
import '../widgets/image_and_video_widgets.dart';

class CreatePost extends StatefulWidget {  
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final GlobalKey<FormState> _primaryTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _primaryContentForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _primaryLinkForm = GlobalKey<FormState>();
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  String title = '';
  String content = '';
  List<String> pollOptions = ['', ''];
  List<String> initialBody = ['', ''];
  int selectedDay = 1;

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
      updateButtonState();
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
      isButtonEnabled = validatePostTitle(title); //&& validateLink(link!);  
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
    });
    if (isLinkAdded) {
      setLastPressedIcon(Icons.attachment_rounded);
    }
    else {
      setLastPressedIcon(null);
    }
  }

  void cancelImageOrVideo () {
    setState(() {
      image = null;
      video = null;
    });
    setLastPressedIcon(null);
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

  void updatePollOption(int optionNumber, String value) {
    setState(() {
      pollOptions[optionNumber - 1] = value;
    });
    formKeys[optionNumber-1].currentState!.save();
  }

  void updateSelectedDay(int selectedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  void removePollOption(int index) {
    setState(() {
      pollOptions.removeAt(index);
      formKeys.removeAt(index);
    });
  }

  void navigateToPostToCommunity() {
    Navigator.of(context).pushNamed('/post-to-community', arguments: {
      'title': title,
      'content': content,
      'link': link,
      'image': image,
      'video':video,
      'pollOptions': pollOptions,
      'selectedDay': selectedDay,
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
                  onIconPress: validatePostTitle(title) ? () {}: () {showDiscardButtomSheet(context);},  // if invalid , pop to home page
                ),
                PostTitle(
                  formKey: _primaryTitleForm,
                  onChanged:updateTitle,
                  initialBody: '',
                ),
                if (image != null)
                  ImageOrVideoWidget(
                    imageOrVideo: image!, 
                    onIconPress: cancelImageOrVideo,
                  ),
                if (video != null)
                   ImageOrVideoWidget(
                    imageOrVideo: video!,
                    onIconPress: cancelImageOrVideo,
                  ),
                if (isLinkAdded)
                   LinkTextField(
                    formKey: _primaryLinkForm,
                    onChanged: updateLink,
                    hintText: 'URL',
                    initialBody: '',
                    onIconPress: addLink,
                ), 
                if (isLinkAdded && link != null && !validateLink(link!))
                  Container(
                    margin:EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text('Oops, this link isn\'t valid. Double-check, and try again.'),
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
                    formkeys: formKeys,
                    pollOptions: pollOptions,
                    selectedDay: selectedDay,
                    updatePollOption: updatePollOption,
                    removePollOption: removePollOption,
                    updateSelectedDay: updateSelectedDay,
                    initialBody: initialBody,
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
1) link validations (el input fields etgannenet)
2) ashouf el video msh shaghal leih
3) ab3at el haga di kollaha lel final content page (almost done)
4) unit testing 
 */