import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/link.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/tags_widgets/add_tag_bottomsheet.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../widgets/header_and_footer_widgets/create_post_header.dart';
import '../widgets/title.dart';
import '../widgets/content.dart';
import '../widgets/header_and_footer_widgets/create_post_footer.dart';
import '../widgets/header_and_footer_widgets/create_post_secondary_footer.dart';
import '../widgets/header_and_footer_widgets/community_and_rules_header.dart';
import '../widgets/show_discard_bottomsheet.dart';
import '../../../generic_widgets/small_custom_button.dart';
import '../widgets/photo_and_video_pickers/image_picker.dart';
import '../widgets/photo_and_video_pickers/video_picker.dart';
import '../widgets/tags_widgets/rendered_tag.dart';
import '../../../generic_widgets/validations.dart';


class FinalCreatePost extends StatefulWidget {

  final String title;
  final String content;
  final String? link;
  final File? image;
  final File? video;
  final bool isLinkAdded;
  final List<Map<String, dynamic>> community;

  const FinalCreatePost({
    Key? key,
    required this.title,
    required this.content,
    this.link,
    this.image,
    this.video,
    required this.isLinkAdded,
    required this.community,
    }) : super(key: key);

  @override
  State<FinalCreatePost> createState() => _FinalCreatePostState();
}

class _FinalCreatePostState extends State<FinalCreatePost> {

  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalLinkForm = GlobalKey<FormState>();

  String finalTitle = '';
  String finalContent ='';
  String communityName = '';
  String communityIcon = '';

  bool isPrimaryFooterVisible = true;
  bool isButtonEnabled = false;
  bool createPoll = false;
  bool isNSFWAllowed = true;
  bool isSpoiler = false;
  bool isNSFW = false;
  bool finalIsLinkAdded = false ;     

  File? image;
  File? video;
  String? link;
  IconData? lastPressedIcon;

  @override
  void initState() {
    super.initState();
    communityName = widget.community[0]['communityName'];
    communityIcon = widget.community[0]['communityIcon'];
    finalIsLinkAdded = widget.isLinkAdded;
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
    link = value;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
    if (_finalLinkForm.currentState != null) {
      _finalLinkForm.currentState!.save();
    }
    });
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = validatePostTitle(finalTitle);   // TODO : check link validation
    });
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

  void extractCommunityData () {
    Map<String, dynamic> communityData = widget.community[0];
    communityName= communityData['communityName'];
    communityIcon = communityData['communityIcon'];
  }

  void navigateToAddTags(){
    Navigator.of(context).pushNamed('/add-tags');
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
                    onPressed: () {},
                    isEnabled: isButtonEnabled,
                    onIconPress : () { showDiscardButtomSheet(context);},
                  ),
                ),
                Container(
                 margin: EdgeInsets.all(10),
                 child:  CommunityAndRulesHeader(
                  communityIcon: communityIcon,
                  communityName: communityName,
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
                if (finalIsLinkAdded)
                   LinkTextField(
                    formKey: _finalLinkForm,
                    onChanged: updateLink,
                    hintText: 'URL',
                    initialBody: widget.link,
                    onIconPress: addLink,
                  ),   
                PostContent(
                  formKey: _finalContentForm,
                  onChanged:  updateContent,
                  hintText: 'body text (optional)',
                  initialBody: widget.content,
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
3) a-check el wel poll wel image wel video byetne2lo walla laa aw han2elhom ezzay
4) mock service 
5) unit testing 
 */