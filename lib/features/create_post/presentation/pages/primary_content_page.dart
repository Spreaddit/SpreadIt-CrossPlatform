import 'package:flutter/foundation.dart';
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
import '../../../generic_widgets/photo_and_video_pickers/image_picker.dart';
import '../../../generic_widgets/photo_and_video_pickers/video_picker.dart';
import '../widgets/poll_widgets/poll.dart';
import '../widgets/link.dart';
import '../widgets/image_and_video_widgets.dart';

class CreatePost extends StatefulWidget {  

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
  Uint8List? imageWeb;
  File? video;
  Uint8List? videoWeb;
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
      isButtonEnabled = validatePostTitle(title) && validatePostTitle(link!);  
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
      setLastPressedIcon(Icons.link);
    }
    else {
      setLastPressedIcon(null);
    }
  }

  void cancelImageOrVideo () {
    setState(() {
      imageWeb = null;
      videoWeb = null;
      image = null;
      video = null;
    });
    setLastPressedIcon(null);
  }

  Future<void> pickImage() async {
    if(kIsWeb) {
      final image = await pickImageFromFilePickerWeb();
      setState(() {
        imageWeb = image;
      });
    }
    else {
      final image = await pickImageFromFilePicker();
      setState(() {
        this.image = image;
      });
    }
  }

  Future<void> pickVideo() async {
    File? video = await pickVideoFromFilePicker.pickVideo();
    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  void openPollWidow() {
    setState(() {
      createPoll = !createPoll;
    });
    print('create poll from primary: $createPoll');
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
      'imageWeb': imageWeb,
      'video':video,
      'videoWeb':videoWeb,
      'pollOptions': pollOptions,
      'selectedDay': selectedDay,
      'createPoll': createPoll,
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
                if (image != null || imageWeb != null)
                  ImageOrVideoWidget(
                    imageOrVideo: image, 
                    imageOrVideoWeb: imageWeb,
                    onIconPress: cancelImageOrVideo,
                  ),
                if (video != null || videoWeb != null)
                   ImageOrVideoWidget(
                    imageOrVideo: video,
                    imageOrVideoWeb: videoWeb,
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
 unit testing 
 */