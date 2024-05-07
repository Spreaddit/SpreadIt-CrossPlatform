import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/create_post/data/submit_post.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/link.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/poll_widgets/poll.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/tags_widgets/add_tag_bottomsheet.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/video_widget.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import '../widgets/header_and_footer_widgets/create_post_header.dart';
import '../widgets/title.dart';
import '../widgets/content.dart';
import '../widgets/header_and_footer_widgets/create_post_footer.dart';
import '../widgets/header_and_footer_widgets/create_post_secondary_footer.dart';
import '../widgets/header_and_footer_widgets/community_and_rules_header.dart';
import '../widgets/show_discard_bottomsheet.dart';
import '../../../generic_widgets/small_custom_button.dart';
import '../../../generic_widgets/photo_and_video_pickers/image_picker.dart';
import '../../../generic_widgets/photo_and_video_pickers/video_picker.dart';
import '../widgets/tags_widgets/rendered_tag.dart';
import '../../../generic_widgets/validations.dart';
import '../widgets/image_and_video_widgets.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/get_specific_category.dart';

/// This page renders the class [FinalCreatePost], which allows the user to make any modifications to the previously created post.
/// It also allows the user to check the [rules] of the community to which he will post and allows the user to add [Spoiler] and [NSFW] tags to the post

class FinalCreatePost extends StatefulWidget {

  final String title;
  final String content;
  final String? link;
  final File? image;
  final Uint8List? imageWeb;
  final File? video;
  final Uint8List? videoWeb;
  final List<String>? pollOptions;
  final int? selectedDay;
  final bool? createPoll;
  final bool? isLinkAdded;
  final List<Community> community;

  const FinalCreatePost({
    Key? key,
    required this.title,
    required this.content,
    this.link,
    this.image,
    this.imageWeb,
    this.video,
    this.videoWeb,
    this.pollOptions,
    this.selectedDay,
    this.createPoll,
    this.isLinkAdded,
    required this.community,
    }) : super(key: key);

  @override
  State<FinalCreatePost> createState() => _FinalCreatePostState();
}

class _FinalCreatePostState extends State<FinalCreatePost> {

  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalLinkForm = GlobalKey<FormState>();
  List<GlobalKey<FormState>> finalFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  String finalTitle = '';
  String finalContent ='';
  String communityName = '';
  String communityIcon = '';
  List<Rule?>? communityRules = [];
  List<String> finalPollOptions = ['', ''];
  List<String> finalInitialBody = ['',''];
  int finalSelectedDay = 1;

  bool isPrimaryFooterVisible = true;
  bool isButtonEnabled = false;
  bool isNSFWAllowed = true;
  bool isSpoiler = false;
  bool isNSFW = false;
  bool finalIsLinkAdded = false ;  
  bool finalCreatePoll = false;   

  File? finalImage;
  Uint8List? finalImageWeb;
  File? finalVideo;
  Uint8List? finalVideoWeb;
  String? finalLink;
  IconData? lastPressedIcon;

  /// [mapCommunityData] : a function which extracts the [communityName], [communityIcon] and [communityRules] from the passsed list of communities

  void mapCommunityData () {
    communityName = widget.community.first.name;
    communityIcon = widget.community.first.image!;
    communityRules = widget.community.first.rules;
  }

  /// [mapPoll] : a function used to map the passed [pollOptions]

  void mapPoll () {
    if (widget.selectedDay != null) {
     finalSelectedDay = widget.selectedDay!;
    }
    finalInitialBody.clear();
    finalPollOptions.clear();
    finalInitialBody.addAll(widget.pollOptions!);
    finalPollOptions.addAll(widget.pollOptions!);
    if(finalPollOptions.length > 2) {
      for(int i = 2; i < finalPollOptions.length; i++) {
        GlobalKey<FormState> newFormKey = GlobalKey<FormState>();
        finalFormKeys.add(newFormKey); 
      }
    }
  }

  @override
  void initState() {
    super.initState();
    mapCommunityData();
    if(widget.isLinkAdded != null) {
      finalIsLinkAdded = widget.isLinkAdded!;
    }
    if(widget.image != null) {
      finalImage = widget.image;
    }
    if(widget.imageWeb != null) {
      finalImageWeb = widget.imageWeb;
    }
    if(widget.video != null) {
      finalVideo = widget.video;
    }
    if(widget.videoWeb != null) {
      finalVideoWeb = widget.videoWeb;
    }
    if(widget.createPoll != null) { 
      mapPoll();
      openPollWidow();
      setLastPressedIcon(Icons.poll);
      }
  }
  
   void updateTitle(String value) {
    finalTitle = value;
    _finalTitleForm.currentState!.save();
    updateButtonState();
  }

  void updateContent(String value) {
    finalContent = value;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
    if (_finalContentForm.currentState != null) {
      _finalContentForm.currentState!.save();
    }
    });
  }

  void updateLink(String value) {
    finalLink = value;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
    if (_finalLinkForm.currentState != null) {
      _finalLinkForm.currentState!.save();
    }
    });
    validatePostTitle(finalLink!);
  }

  void updateButtonState() {
    if (finalLink == null) {
      setState(() {
        isButtonEnabled = validatePostTitle(finalTitle);
      });
    }
    else {
      isButtonEnabled = validatePostTitle(finalTitle) && validatePostTitle(finalLink!);  
    }
  }

  void setLastPressedIcon(IconData? passedIcon) {
    setState(() {
      lastPressedIcon = passedIcon;
    });
  }

  void updateIsSpoiler() {
    setState(() {
      isSpoiler = !isSpoiler;
    });
    print(isSpoiler);
  }

  void updateIsNSFW () {
    setState(() {
      isNSFW = !isNSFW;
    });
    print(isNSFW);
  }

  void toggleFooter() {
    setState(() {
      isPrimaryFooterVisible = !isPrimaryFooterVisible;
    });
  }

  void addLink() {
    setState(() {
      finalIsLinkAdded = !finalIsLinkAdded;
    });
    if (finalIsLinkAdded) {
      setLastPressedIcon(Icons.link);
    }
    else {
      setLastPressedIcon(null);
    }
  }

  void cancelImageOrVideo () {
    setState(() {
      finalImageWeb = null;
      finalVideoWeb = null;
      finalImage = null;
      finalVideo = null;
    });
    setLastPressedIcon(null);
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final image = await pickImageFromFilePickerWeb();
      setState(() {
        finalImageWeb = image;
      });
    }
    else {
      final image = await pickImageFromFilePicker();
      setState(() {
        finalImage = image;
      });
    }
  }
  
  Future<void> pickVideo() async {
    if(kIsWeb) {
      final video = await pickVideoFromFilePickerWeb();
      setState(() {
        finalVideoWeb = video;
      });
    }
    else {
      final video = await pickVideoFromFilePicker();
      setState(() {
        finalVideo = video;
      });
    }
  }

  void openPollWidow() {
    setState(() {
      finalCreatePoll = !finalCreatePoll;
    });
  }

  void updatePollOption(int optionNumber, String value) {
    setState(() {
      finalPollOptions[optionNumber - 1] = value;
      print(finalPollOptions[optionNumber-1]);
    });
    finalFormKeys[optionNumber-1].currentState!.save();
  }

  void updateSelectedDay(int selectedDay) {
    setState(() {
      finalSelectedDay = selectedDay;
    });
  }

  void removePollOption(int index) {
    setState(() {
      finalPollOptions.removeAt(index);
      finalFormKeys.removeAt(index);
    });
  }


  void navigateToAddTags(){
    Navigator.of(context).pushNamed('/add-tags');
  }

  void returnToHomePage (BuildContext context) {
    Navigator.of(context).pushNamed('/home');
  }

  void submit () async {
   String response = await submitPost(
      finalTitle, finalContent, communityName, finalPollOptions, finalSelectedDay, finalLink, finalImage, finalImageWeb, finalVideo, finalVideoWeb, isSpoiler, isNSFW);
    if (response == '400') {
      CustomSnackbar(content: 'Invalid post ID or post data').show(context);
    }
    else if (response == '500') {
      CustomSnackbar(content: 'Internal server error').show(context);
    }
    else {
      navigateToPostCardPage(context,response, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  child: CreatePostHeader(
                    buttonText: "Post",
                    onPressed: submit,
                    isEnabled: isButtonEnabled,
                    onIconPress : () { showDiscardButtomSheet(context);},
                  ),
                ),
                Container(
                 margin: EdgeInsets.all(10),
                 child:  CommunityAndRulesHeader(
                  communityIcon: communityIcon,
                  communityName: communityName,
                  communityRules: communityRules,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SmallButton(
                    buttonText: 'Add tags',
                    onPressed: () {
                      showAddTagButtomSheet(
                        context, 
                        isSpoiler, 
                        isNSFW, 
                        isNSFWAllowed, 
                        updateIsSpoiler,
                        updateIsNSFW,
                        );
                      },
                    isEnabled: true,
                    width: 150,
                    height: 10,
                  ),
                ),
                if (isSpoiler && !isNSFW)
                    RenderedTag(icon: Icons.new_releases_rounded, text: 'Spoiler'),
                if (!isSpoiler && isNSFW)
                    RenderedTag(icon: Icons.warning_rounded, text: 'NSFW'), 
                if (isSpoiler && isNSFW)
                  Row (
                    children: [
                      RenderedTag(icon: Icons.new_releases_rounded, text: 'Spoiler'),
                      RenderedTag(icon: Icons.warning_rounded, text: 'NSFW'),
                    ],
                  ),             
                PostTitle(
                  formKey: _finalTitleForm,
                  onChanged: updateTitle,
                  initialBody: widget.title,
                ),
                if (finalImage != null || finalImageWeb != null)
                  ImageOrVideoWidget(
                    imageOrVideo: finalImage,
                    imageOrVideoWeb: finalImageWeb,
                    onIconPress: cancelImageOrVideo,
                  ), 
                if (finalVideo != null || finalVideoWeb != null)
                   VideoWidget(
                    video: finalVideo,
                    videoWeb: finalVideoWeb,
                    onIconPress: cancelImageOrVideo,
                  ),
                if (finalIsLinkAdded)
                   LinkTextField(
                    formKey: _finalLinkForm,
                    onChanged: updateLink,
                    hintText: 'URL',
                    initialBody: widget.link,
                    onIconPress: addLink,
                  ),
                if (finalIsLinkAdded  && finalLink != null && !validateLink(finalLink!)) 
                  Container(
                    margin:EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text('Oops, this link isn\'t valid. Double-check, and try again.'),
                  ),      
                PostContent(
                  formKey: _finalContentForm,
                  onChanged:  updateContent,
                  hintText: 'body text (optional)',
                  initialBody: widget.content,
                ),
                if (finalCreatePoll)
                  Poll(
                    onPollCancel: openPollWidow,
                    setLastPressedIcon: setLastPressedIcon,
                    formkeys: finalFormKeys,
                    pollOptions: finalPollOptions,
                    selectedDay: finalSelectedDay,
                    updatePollOption: updatePollOption,
                    removePollOption: removePollOption,
                    updateSelectedDay: updateSelectedDay,
                    initialBody: finalInitialBody,
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
1) ashouf el video msh shaghal leih
2) mock service 
3) unit testing 
 */