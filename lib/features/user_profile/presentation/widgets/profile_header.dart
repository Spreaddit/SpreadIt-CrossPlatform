import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:spreadit_crossplatform/features/generic_widgets/open_url.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/image_picker.dart';
import 'package:spreadit_crossplatform/features/user_interactions/data/user_interactions/user_to_user/interact.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/icon_picker.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/social_media_button.dart';

import '../../../generic_widgets/bottom_model_sheet.dart';
import '../../../generic_widgets/share.dart';

/// The `ProfileHeader` widget displays the header section of a user's profile.
///
/// It includes the user's profile picture, background image, username, user info, about section,
/// follow button (if applicable), chat button, and social media links.
class ProfileHeader extends StatefulWidget {
  /// The URL of the background image.
  final String backgroundImage;

  /// The URL of the profile picture.
  final String profilePicture;

  /// The username of the user.
  final String username;

  /// Additional user information.
  final String userinfo;

  /// Information about the user.
  final String about;

  /// Indicates whether the profile being viewed is the current user's profile.
  final bool myProfile;

  /// Indicates whether the user is being followed.
  final bool followed;

  /// Callback function for the chat button.
  final VoidCallback? onStartChatPressed;

  /// Callback function for the follow button.
  final VoidCallback? follow;

  /// Callback function for the edit profile button.
  final VoidCallback? editprofile;

  /// List of social media links associated with the user's profile.
  final List<Map<String, dynamic>> socialMediaLinks;

  /// The file representing the background image (for local images).
   File? backgroundImageFile;

  /// The file representing the profile picture (for local images).
   File? profileImageFile;

  /// The byte data representing the background image (for web images).
   Uint8List? backgroundImageWeb;

  /// The byte data representing the profile picture (for web images).
   Uint8List? profileImageWeb;

  /// Creates a `ProfileHeader` widget.
  ///
  /// The `backgroundImage`, `profilePicture`, `username`, `userinfo`, `about`, and `myProfile` parameters are required.
  ProfileHeader({
    required this.backgroundImage,
    required this.profilePicture,
    required this.username,
    required this.userinfo,
    required this.about,
    required this.myProfile,
    required this.followed,
    this.onStartChatPressed,
    this.follow,
    this.editprofile,
    this.socialMediaLinks = const [],
    this.backgroundImageFile,
    this.profileImageFile,
    this.backgroundImageWeb,
    this.profileImageWeb,
  });

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

/// The state for the `ProfileHeader` widget.
class _ProfileHeaderState extends State<ProfileHeader> {
  double _headerHeight = 0;

  @override
  void initState() {
    super.initState();
    // Set _headerHeight when the widget is first inserted into the tree
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _headerHeight = context.size!.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const double iconSizePercentage = 0.07;
    final double iconSize =
        (screenWidth < screenHeight ? screenWidth : screenHeight) *
            iconSizePercentage;
    final double photosize = kIsWeb
        ? screenHeight * 0.065
        : (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.1;

   
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: screenWidth,
              height: _headerHeight,
              child: ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: [0.0, 0.7],
                    ).createShader(bounds);
                  },
                  child: Image(
                    image: selectImage(
                      widget.backgroundImageFile,
                      widget.backgroundImage,
                      widget.backgroundImageWeb,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // TO DO : Update this when search is implemented
                            },
                            color: Colors.white,
                            iconSize: iconSize,
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              sharePressed('Profile Link isa');
                            },
                            color: Colors.white,
                            iconSize: iconSize,
                          ),
                          if (!widget.myProfile)
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomBottomSheet(
                                      icons: [
                                        CupertinoIcons.envelope,
                                        CupertinoIcons.add_circled,
                                        Icons.block,
                                        CupertinoIcons.flag,
                                      ],
                                      text: [
                                        'Send a message',
                                        'Add to custom feed',
                                        'Block',
                                        'Report a profile'
                                      ],
                                      onPressedList: [
                                        () => {},
                                        () => {},
                                        () => { interactWithUser(userId:widget.username, action :InteractWithUsersActions.block)},
                                        () => {},
                                      ],
                                    );
                                  },
                                );
                              },
                              color: Colors.white,
                              iconSize: iconSize,
                            ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: kIsWeb ? screenHeight * 0.02 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: kIsWeb
                                ? screenHeight * 0.02
                                : screenHeight * 0.08),
                        CircleAvatar(
                          radius: photosize,
                          backgroundImage: selectImage(
                            widget.profileImageFile,
                            widget.profilePicture,
                            widget.profileImageWeb,
                          ),
                        ),
                        SizedBox(
                            height: kIsWeb
                                ? screenHeight * 0.01
                                : screenHeight * 0.02),
                        Row(
                          children: [
                            if (!widget.myProfile)
                              OutlinedButton(
                                onPressed: widget.follow,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.followed ? 'Following' : 'Follow',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            if (!widget.myProfile)
                              Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                      CupertinoIcons.chat_bubble_text_fill),
                                  onPressed: widget.onStartChatPressed,
                                  color: Colors.white,
                                  iconSize: iconSize * 0.75,
                                ),
                              ),
                            if (widget.myProfile)
                              OutlinedButton(
                                onPressed: widget.editprofile,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          widget.username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height: kIsWeb
                                ? screenHeight * 0.02
                                : screenHeight * 0.02),
                        Text(
                          widget.userinfo,
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                            height: kIsWeb
                                ? screenHeight * 0.02
                                : screenHeight * 0.02),
                        Text(
                          widget.about,
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                            height: kIsWeb
                                ? screenHeight * 0.02
                                : screenHeight * 0.02),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          children: widget.socialMediaLinks.asMap().entries.map(
                            (entry) {
                              final platformData = entry.value;
                              final platformName = platformData['platform'];
                              final iconName =
                                  PlatformIconMapper.getIconData(platformName);
                              final color =
                                  PlatformIconMapper.getColor(platformName);
                              return SocialMediaButton(
                                icon: iconName,
                                text: platformData['displayName'],
                                iconColor: color,
                                backgroundColor: Colors.white70,
                                handleSelection: () {
                                  launchURL(platformData['url']);
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
