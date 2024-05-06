import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_bottom_sheet.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/data/get_muted_communities.dart';

/// A custom app bar widget for the community page.
class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructs a [CommunityAppBar].
  ///
  /// The [bannerImageLink] is the link to the community banner image.
  /// The [communityName] is the name of the community.
  /// The [blurImage] determines whether to apply a blur effect to the banner image and display community name.
  /// The [joined] determines whether the user is a member of this community
  CommunityAppBar({
    Key? key,
    required this.bannerImageLink,
    required this.communityName,
    this.blurImage = false,
    required this.joined,
  }) : super(key: key);

  final String bannerImageLink;
  final String communityName;
  final bool blurImage;
  bool joined;

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
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
              ),
              color: Colors.white,
              onPressed: () async {
                bool isMuted = await getIsMuted(communityName , context);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CommunityBottomSheet(
                      communityName: communityName,
                      muted: isMuted,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Function to get if the community is currently muted by the user.
Future<bool> getIsMuted(String communityName, BuildContext context) async {
  try {
    GetMutedCommunities getMutedCommunities = GetMutedCommunities();
    List<Community> mutedCommunities =
        await getMutedCommunities.getMutedCommunities();

    // Check if communityName is present in the mutedCommunities list
    bool isMuted =
        mutedCommunities.any((community) => community.name == communityName);
    return isMuted;
  } catch (e) {
    CustomSnackbar(content: "an error occurred , please try again later")
        .show(context);

    return false;
  }
}
