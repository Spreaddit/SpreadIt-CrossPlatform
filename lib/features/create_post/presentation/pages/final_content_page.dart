import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_post/data/submit_post.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/content.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/link.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/poll_widgets/poll.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/tags_widgets/add_tag_bottomsheet.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/video_widget.dart';
import 'dart:io';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/get_allowed_post_settings.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/post_settings_model_class.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import '../widgets/header_and_footer_widgets/create_post_header.dart';
import '../widgets/title.dart';
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
import 'package:spreadit_crossplatform/features/schedule_posts/data/is_user_moderator_service.dart';
import 'package:intl/intl.dart';

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

  /// [isFromCommunityPage] : a boolean value which indicates if the user is posting from a community or not
  final bool? isFromCommunityPage;

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
    this.isFromCommunityPage,
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
  String finalContent = '';
  String communityName = '';
  String communityIcon = '';
  List<Rule?>? communityRules = [];
  List<String> finalPollOptions = ['', ''];
  List<String> finalInitialBody = ['', ''];
  int finalSelectedDay = 1;

  bool isPrimaryFooterVisible = true;
  bool isButtonEnabled = false;
  bool allowScheduling = false;
  bool isModerator = true;
  bool isNSFWAllowed = true;
  bool isSpoiler = false;
  bool isNSFW = false;
  bool finalIsLinkAdded = false;
  bool finalCreatePoll = false;
  bool isNotApprovedForPosting = false;
  bool isDateChanged = false;
  bool showPhotoIcon = true;
  bool showVideoIcon = true;
  bool showLinkIcon = true;
  bool showPollIcon = true;
  File? finalImage;
  Uint8List? finalImageWeb;
  File? finalVideo;
  Uint8List? finalVideoWeb;
  String? finalLink;
  IconData? lastPressedIcon;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isScheduled = false;
  PostSettings? postSettings;

  /// [mapCommunityData] : a function which extracts the [communityName], [communityIcon] and [communityRules] from the passsed list of communities

  void mapCommunityData() {
    communityName = widget.community.first.name;
    communityIcon = widget.community.first.image!;
    communityRules = widget.community.first.rules;
  }

  /// [mapPoll] : a function used to map the passed [pollOptions]

  void mapPoll() {
    if (widget.selectedDay != null) {
      finalSelectedDay = widget.selectedDay!;
    }
    finalInitialBody.clear();
    finalPollOptions.clear();
    finalInitialBody.addAll(widget.pollOptions!);
    finalPollOptions.addAll(widget.pollOptions!);
    if (finalPollOptions.length > 2) {
      for (int i = 2; i < finalPollOptions.length; i++) {
        GlobalKey<FormState> newFormKey = GlobalKey<FormState>();
        finalFormKeys.add(newFormKey);
      }
    }
  }

  void fetchAllowedSettings(String communityName) async {
    postSettings = await fetchPostSettingsData(communityName);
    adjustPostSettings();
  }

  void adjustPostSettings() {
    if (!postSettings!.pollsAllowed) {
      showPollIcon = false;
      finalCreatePoll = false;
      CustomSnackbar(content: "Polls are not allowed ").show(context);
    }
    if (postSettings!.postTypeOptions == 'text posts only') {
      showLinkIcon = false;
      showPhotoIcon = false;
      showPhotoIcon = false;
      showPollIcon = false;
      finalImage = null;
      finalImageWeb = null;
      finalVideo = null;
      finalVideoWeb = null;
      finalIsLinkAdded = false;
      finalCreatePoll = false;
      CustomSnackbar(content: "Only text posts are allowed ").show(context);
    } else if (postSettings!.postTypeOptions == 'links only') {
      showPhotoIcon = false;
      showPhotoIcon = false;
      showPollIcon = false;
      finalImage = null;
      finalImageWeb = null;
      finalVideo = null;
      finalVideoWeb = null;
      finalCreatePoll = false;
      CustomSnackbar(content: "Only links are allowed ").show(context);
    }
  }

  @override
  void initState() {
    super.initState();
    mapCommunityData();
    checkIfCanPost();
    isModeratorFunction();
    if (widget.isLinkAdded != null) {
      finalIsLinkAdded = widget.isLinkAdded!;
    }
    if (widget.image != null) {
      finalImage = widget.image;
    }
    if (widget.imageWeb != null) {
      finalImageWeb = widget.imageWeb;
    }
    if (widget.video != null) {
      finalVideo = widget.video;
    }
    if (widget.videoWeb != null) {
      finalVideoWeb = widget.videoWeb;
    }
    if (widget.createPoll != null) {
      mapPoll();
      openPollWidow();
      setLastPressedIcon(Icons.poll);
    }
    fetchAllowedSettings(communityName);
  }

  /// [checkIfCanPost] : a function used to check if users aren't approved for posting in the community

  void checkIfCanPost() async {
    await checkIfNotApproved(communityName, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForPosting = value;
    });
    if (mounted) {
      setState(() {
        //TODO: check if this causes exception
        isButtonEnabled =
            !isNotApprovedForPosting && validatePostTitle(finalTitle);
      });
    }
  }

  /// [isModeratorFunction] : a function which checks if the user is a moderator of the community
  Future<void> isModeratorFunction() async {
    bool moderatorStatus =
        await IsUserModeratorService().isUserModerator(communityName);
    setState(() {
      isModerator = moderatorStatus;
    });
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
        isButtonEnabled =
            validatePostTitle(finalTitle) && !isNotApprovedForPosting;

        allowScheduling = validatePostTitle(finalTitle) && isModerator;
      });
    } else {
      setState(() {
        isButtonEnabled = validatePostTitle(finalTitle) &&
            validatePostTitle(finalLink!) &&
            !isNotApprovedForPosting;

        allowScheduling = validatePostTitle(finalTitle) &&
            validatePostTitle(finalLink!) &&
            isModerator;
      });
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

  void updateIsNSFW() {
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
    } else {
      setLastPressedIcon(null);
    }
  }

  void cancelImageOrVideo() {
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
    } else {
      final image = await pickImageFromFilePicker();
      setState(() {
        finalImage = image;
      });
    }
  }

  Future<void> pickVideo() async {
    if (kIsWeb) {
      final video = await pickVideoFromFilePickerWeb();
      setState(() {
        finalVideoWeb = video;
      });
    } else {
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
      print(finalPollOptions[optionNumber - 1]);
    });
    finalFormKeys[optionNumber - 1].currentState!.save();
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

  void navigateToAddTags() {
    Navigator.of(context).pushNamed('/add-tags');
  }

  void returnToHomePage(BuildContext context) {
    Navigator.of(context).pushNamed('/home');
  }

  void submit() async {
    print("IsScheduled: $isScheduled");

    DateTime? selectedDateTime;
    if (isScheduled) {
      selectedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
    }
    String response = await submitPost(
      finalTitle,
      finalContent,
      communityName,
      finalPollOptions,
      finalSelectedDay,
      finalLink,
      finalImage,
      finalImageWeb,
      finalVideo,
      finalVideoWeb,
      isSpoiler,
      isNSFW,
      isScheduled ? selectedDateTime : null,
    );

    if (response == '400') {
      CustomSnackbar(content: 'Invalid post ID or post data').show(context);
    } else if (response == '500') {
      CustomSnackbar(content: 'Internal server error').show(context);
    } else if (isScheduled) {
      CustomSnackbar(content: 'Scheduled successfully !').show(context);
      Navigator.of(context).pop();
    } else if (widget.isFromCommunityPage == true) {
      CustomSnackbar(content: 'Posted successfully !').show(context);
      Navigator.of(context).pop();
    } else {
      CustomSnackbar(content: 'Posted successfully !').show(context);
      navigateToPostCardPage(context: context, postId: response);
    }
  }

  void showDateTimePickerModalSheet(BuildContext context, Function callback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return IntrinsicHeight(
                key: UniqueKey(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                            callback();
                          },
                        ),
                        title: Text('Schedule Post',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: OutlinedButton(
                          onPressed: () {
                            if (isScheduled && !isDateChanged) {
                              setState(() {
                                isScheduled = false;
                                isDateChanged = false;
                                selectedDate = null;
                                selectedTime = null;
                              });
                            }
                            Navigator.of(context).pop();
                            callback();
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(0, 69, 172, 1.0),
                            foregroundColor: Colors.white,
                            side: BorderSide(
                                color: const Color.fromRGBO(0, 69, 172, 1.0),
                                width: 2),
                          ),
                          child: isScheduled && !isDateChanged
                              ? Text('Clear')
                              : Text('Save'),
                        ),
                      ),
                      ListTile(
                        title: Text('Starts on date'),
                        trailing: TextButton(
                          child: Text(
                            selectedDate != null
                                ? '${DateFormat.MMMd().format(selectedDate!)}, ${selectedDate!.year}'
                                : '${DateFormat.MMMd().format(DateTime.now())}, ${DateTime.now().year}',
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 69, 172, 1.0)),
                          ),
                          onPressed: () async {
                            isScheduled = true;
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                                isScheduled = true;
                                isDateChanged = true;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Starts on time'),
                        trailing: TextButton(
                          child: Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : DateFormat.jm().format(DateTime.now()),
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 69, 172, 1.0)),
                          ),
                          onPressed: () async {
                            isScheduled = true;
                            selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dialOnly,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                      foregroundColor:
                                          const Color.fromRGBO(0, 69, 172, 1.0),
                                    )),
                                    canvasColor: Colors.red,
                                    primaryColor:
                                        Colors.white, // header background color
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.grey, // dial hand color
                                      onPrimary:
                                          Colors.white, // dial hand dot color
                                      onSurface:
                                          Colors.black, // dial numbers color
                                      surface: Colors
                                          .white, // dial inner background color
                                    ),
                                    dialogBackgroundColor:
                                        Colors.white, // dialog background color
                                    timePickerTheme: TimePickerThemeData(
                                      dialHandColor: const Color.fromRGBO(
                                          0, 69, 172, 1.0), // dial hand color
                                      hourMinuteTextColor:
                                          Colors.black, // dial numbers color
                                      hourMinuteColor: Colors
                                          .white, // time background colour
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedTime != null) {
                              setState(() {
                                isScheduled = true;
                                isDateChanged = true;
                              });
                            }
                            // Use selectedTime here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void showSchedulePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return IntrinsicHeight(
                key: UniqueKey(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Post Settings',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Schedule Post'),
                        trailing: isScheduled
                            ? Text(
                                '${DateFormat.MMMd().format(selectedDate!)}, ${selectedDate!.year} ${selectedTime!.format(context)}',
                                style: TextStyle(color: Colors.blue),
                              )
                            : Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          if (!isScheduled) {
                            setState(() {
                              isScheduled = true;
                              selectedDate = DateTime.now();
                              selectedTime = TimeOfDay(
                                  hour: TimeOfDay.now().hour + 1,
                                  minute: TimeOfDay.now().minute);
                              isDateChanged = true;
                            });
                          }
                          if (isScheduled) {
                            setState(() {
                              isDateChanged = false;
                              isScheduled = true;
                            });
                          }
                          showDateTimePickerModalSheet(context, () {
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).then((value) => setState(() {}));
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
                    allowScheduling: allowScheduling,
                    showSchedulePostBottomSheet: showSchedulePostBottomSheet,
                    buttonText: isScheduled ? "Schedule" : "Post",
                    onPressed: submit,
                    isEnabled: isButtonEnabled,
                    onIconPress: () {
                      showDiscardButtomSheet(context,
                          isFromCommunityPage: widget.isFromCommunityPage);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CommunityAndRulesHeader(
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
                  RenderedTag(
                      icon: Icons.new_releases_rounded, text: 'Spoiler'),
                if (!isSpoiler && isNSFW)
                  RenderedTag(icon: Icons.warning_rounded, text: 'NSFW'),
                if (isSpoiler && isNSFW)
                  Row(
                    children: [
                      RenderedTag(
                          icon: Icons.new_releases_rounded, text: 'Spoiler'),
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
                if (finalIsLinkAdded &&
                    finalLink != null &&
                    !validateLink(finalLink!))
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text(
                        'Oops, this link isn\'t valid. Double-check, and try again.'),
                  ),
                PostContent(
                  formKey: _finalContentForm,
                  onChanged: updateContent,
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
          isPrimaryFooterVisible
              ? PostFooter(
                  toggleFooter: toggleFooter,
                  showAttachmentIcon: showLinkIcon,
                  showPhotoIcon: showPhotoIcon,
                  showVideoIcon: showVideoIcon,
                  showPollIcon: showPollIcon,
                  onLinkPress: addLink,
                  onImagePress: pickImage,
                  onVideoPress: pickVideo,
                  onPollPress: openPollWidow,
                  lastPressedIcon: lastPressedIcon,
                  setLastPressedIcon: setLastPressedIcon,
                )
              : SecondaryPostFooter(
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