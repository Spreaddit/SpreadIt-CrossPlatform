import 'package:flutter/material.dart';
import 'dart:ui';

/// A custom app bar widget for the community page.
class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructs a [CommunityAppBar].
  ///
  /// The [bannerImageLink] is the link to the community banner image.
  /// The [communityName] is the name of the community.
  /// The [blurImage] determines whether to apply a blur effect to the banner image and display community name.
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
      void navigateToCommunitySearch() {
        Navigator.of(context).pushNamed('/community-or-user-search', 
        arguments: {
          'communityOrUserName': communityName,
          'communityOrUserIcon': bannerImageLink != '' ? bannerImageLink : 'assets/images/LogoSpreadIt.png' ,
        });
      }
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
       actions: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.75),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.search,
              ),
              color: Colors.white,
              onPressed: navigateToCommunitySearch,
            ),
          ),
        ), 
       ],  
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
