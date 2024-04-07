import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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


class FinalCreatePost extends StatefulWidget {
  const FinalCreatePost({Key? key}) : super(key: key);

  @override
  State<FinalCreatePost> createState() => _FinalCreatePostState();
}

class _FinalCreatePostState extends State<FinalCreatePost> {

  final GlobalKey<FormState> _finalTitleForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _finalContentForm = GlobalKey<FormState>();

  String title = '';
  String content ='';

  bool isPrimaryFooterVisible = true;
  bool isButtonEnabled = false;
  bool createPoll = false;
  bool isNSFWAllowed = true;
  bool isSpoiler = false;
  bool isNSFW = false;

  File? image;
  File? video;
  IconData? lastPressedIcon;
  
   void updateTitle(String value) {
    title = value;
    _finalTitleForm.currentState!.save();
    updateButtonState();
  }

  void updateContent(String value) {
    content = value;
    _finalContentForm.currentState!.save();
      
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = title.isNotEmpty && !RegExp(r'^[\W_]+$').hasMatch(title);
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
                  communityIcon: "./assets/images/LogoSpreadIt.png",
                  communityName: 'r/ask reddit',
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
                PostContent(
                  formKey: _finalContentForm,
                  onChanged:  updateContent,
                  hintText: 'body text (optional)',
                  initialBody: ''
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
            onImagePress: pickImage,
            onVideoPress: pickVideo,
            onPollPress: openPollWidow,
            lastPressedIcon: lastPressedIcon, 
            setLastPressedIcon: setLastPressedIcon,
            ) : SecondaryPostFooter(
              onLinkPress: () {},
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
2) asayyev kol haga f variable w akhod el haga ml pages elli ablaha 
---> a-make sure law ana aslan 3amla post men gowwa community mafish haga hakhodha men pages ablaha 
3) navigations
4) mock service 
5) unit testing 
 */