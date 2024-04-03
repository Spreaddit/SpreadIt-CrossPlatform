import 'package:flutter/material.dart';

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
    final double photosize =
        (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.1;

    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0), Colors.transparent],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        Image.network(
          backgroundImage,
          fit: BoxFit.cover,
          width: screenWidth,
          height: screenHeight * 0.5,
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
                          // Your onPressed logic here
                        },
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      if (!myProfile)
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          color: Colors.white,
                          iconSize: iconSize,
                        ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.08),
                    CircleAvatar(
                      radius: photosize,
                      backgroundImage: NetworkImage(profilePicture),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Buttons
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.message_rounded),
                              onPressed: onStartChatPressed,
                              color: Colors.white,
                              iconSize: iconSize * 0.8,
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
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      userinfo,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
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
