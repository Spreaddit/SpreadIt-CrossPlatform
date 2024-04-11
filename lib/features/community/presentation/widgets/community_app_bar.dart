import 'package:flutter/material.dart';
import 'dart:ui';

class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommunityAppBar({
    Key? key,
    required this.bannerImageLink,
    required this.communityName,
    this.blurImage = false,
  }) : super(key: key);

  final String bannerImageLink;
  final String communityName;
  final bool blurImage;

  @override
  Size get preferredSize => Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: (bannerImageLink != "")
                  ? NetworkImage(bannerImageLink)
                  : AssetImage('assets/images/LogoSpreadIt.png')
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          if (blurImage)
            ClipRRect(
              // Clip it cleanly.
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                  color: Colors.black.withOpacity(0.75),
                  alignment: Alignment.centerLeft,
                  child: null,
                ),
              ),
            ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.75),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            color: Colors.white,
            onPressed: (() {
              Navigator.pop(context);
            }),
          ),
        ),
      ),
      title: blurImage
          ? Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "r/$communityName",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          : null,
    );
  }
}
