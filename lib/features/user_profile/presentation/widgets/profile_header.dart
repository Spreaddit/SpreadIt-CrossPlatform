import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String backgroundImage;
  final String profilePicture;
  final String username;
  final String userinfo;
  final String about;

  ProfileHeader({
    required this.backgroundImage,
    required this.profilePicture,
    required this.username ,
    required this.userinfo ,
    required this.about ,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size
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
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          // Your onPressed logic here
                        },
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
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
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.message_rounded),
                            onPressed: () {
                              // Your onPressed logic here
                            },
                            color: Colors.white,
                            iconSize: iconSize * 0.8, // Adjust icon size
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
