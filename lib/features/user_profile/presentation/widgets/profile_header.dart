import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/open_url.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/image_picker.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/report_modal.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/widgets/user_card.dart';
import 'package:spreadit_crossplatform/features/user_interactions/data/user_interactions/user_to_user/interact.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/class_models/followers_class_model.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/get_users_follow.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/icon_picker.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/social_media_button.dart';
import '../../../generic_widgets/bottom_model_sheet.dart';
import '../../../generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/widgets/invitation_to_moderate.dart';

/// The `ProfileHeader` widget displays the header section of a user's profile.
///
/// It includes the user's profile picture, background image, displayName, user info, about section,
/// follow button (if applicable), chat button, and social media links.
class ProfileHeader extends StatefulWidget {
  /// The URL of the background image.
  final String backgroundImage;

  /// The URL of the profile picture.
  final String profilePicture;

  /// The displayName of the user.
  final String displayName;

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
  final File? backgroundImageFile;

  /// The file representing the profile picture (for local images).
  final File? profileImageFile;

  /// The byte data representing the background image (for web images).
  final Uint8List? backgroundImageWeb;

  /// The byte data representing the profile picture (for web images).
  final Uint8List? profileImageWeb;

  final List<Community> moderatorCommunities;

  /// Creates a `ProfileHeader` widget.
  ///
  /// The `backgroundImage`, `profilePicture`, `displayName`, `userinfo`, `about`, and `myProfile` parameters are required.
  ProfileHeader({
    required this.backgroundImage,
    required this.profilePicture,
    required this.displayName,
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
    this.moderatorCommunities = const [],
  });

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

/// The state for the `ProfileHeader` widget.
class _ProfileHeaderState extends State<ProfileHeader> {
  double _headerHeight = 0;
  List<FollowUser> followerslist = [];
  String url = '';

  @override
  void initState() {
    super.initState();
    if (widget.myProfile) {
      getFollowers();
    }
    url = Uri.base.toString();
    List<String> parts = url.split('/');
    String username = parts.last;
    if (username == 'user-profile') {
      url = '$url/${widget.username}';
    }
    // Set _headerHeight when the widget is first inserted into the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _headerHeight = context.size!.height + 50.0;
      });
    });
  }

  Future<void> getFollowers() async {
    List<FollowUser> users = await getFollowersUsers();
    setState(() {
      followerslist = users;
    });
  }

  void navigateToUserSearch() {
    Navigator.of(context).pushNamed('/community-or-user-search', arguments: {
      'communityOrUserName': widget.username,
      'communityOrUserIcon': widget.profilePicture,
      'fromUserProfile': true,
      'fromCommunityPage': false,
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
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                        },
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: navigateToUserSearch,
                            color: Colors.white,
                            iconSize: iconSize,
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              sharePressed(kIsWeb? url : "https://app.spreadit.me/user-profile/${widget.username}");
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
                                        Icons.block,
                                        CupertinoIcons.flag,
                                      ],
                                      text: [
                                        'Send a message',
                                        'Block',
                                        'Report a profile'
                                      ],
                                      onPressedList: [
                                        () => {
                                              Navigator.of(context)
                                                  .pushNamed('/inbox')
                                            },
                                        () => {
                                              interactWithUser(
                                                  userId: widget.displayName,
                                                  action:
                                                      InteractWithUsersActions
                                                          .block)
                                            },
                                        () => {
                                              ReportModal(context, "", "0", "0",
                                                  false, true, widget.username)
                                            
                                            },
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
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/new-chat');
                                  },
                                  color: Colors.white,
                                  iconSize: iconSize * 0.75,
                                ),
                              ),
                            if (!widget.myProfile &&
                                widget.moderatorCommunities.isNotEmpty)
                              Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: IconButton(
                                  icon: Icon(Ionicons.person_add_outline),
                                  onPressed: () {
                                    showModalBottomSheetInvite(
                                        context,
                                        widget.moderatorCommunities,
                                        widget.username);
                                  },
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
                          widget.displayName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                        if (followerslist.isNotEmpty && widget.myProfile)
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/followers-page', arguments: {
                                'followers': followerslist,
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${followerslist.length} followers',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        if (followerslist.isNotEmpty && widget.myProfile)
                          SizedBox(
                              height: kIsWeb
                                  ? screenHeight * 0.015
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
                                ? screenHeight * 0.015
                                : screenHeight * 0.02),
                        if (widget.about != '')
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
                                ? screenHeight * 0.015
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
