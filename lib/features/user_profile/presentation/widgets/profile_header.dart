import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../generic_widgets/bottom_model_sheet.dart';
import '../../../generic_widgets/share.dart';

class ProfileHeader extends StatelessWidget {
  final String backgroundImage;
  final String profilePicture;
  final String username;
  final String userinfo;
  final String about;
  final bool myProfile;
  final bool followed;
  final VoidCallback? onStartChatPressed;
  final VoidCallback? follow;
  final VoidCallback? editprofile;

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
  });

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
    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: kIsWeb ? screenHeight * 0.52 : screenHeight * 0.5,
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
            child: Image.network(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
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
                          sharePressed('hola');
                        },
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      if (!myProfile)
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
                                    () => {},
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
                padding:
                    EdgeInsets.only(left: kIsWeb ? screenHeight * 0.02 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height:
                            kIsWeb ? screenHeight * 0.02 : screenHeight * 0.08),
                    CircleAvatar(
                      radius: photosize,
                      backgroundImage: NetworkImage(profilePicture),
                    ),
                    SizedBox(
                        height:
                            kIsWeb ? screenHeight * 0.01 : screenHeight * 0.02),
                    Row(
                      children: [
                        if (!myProfile)
                          OutlinedButton(
                            onPressed: follow,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                followed ? 'Following' : 'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        if (!myProfile)
                          Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                            ),
                            child: IconButton(
                              icon: Icon(CupertinoIcons.chat_bubble_text_fill),
                              onPressed: onStartChatPressed,
                              color: Colors.white,
                              iconSize: iconSize * 0.75,
                            ),
                          ),
                        if (myProfile)
                          OutlinedButton(
                            onPressed: editprofile,
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
                      username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                        height:
                            kIsWeb ? screenHeight * 0.02 : screenHeight * 0.02),
                    Text(
                      userinfo,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                        height:
                            kIsWeb ? screenHeight * 0.02 : screenHeight * 0.02),
                    Text(
                      about,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
