import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';

void navigateToCommunity(
  BuildContext context,
  String communityName,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
        settings: RouteSettings(
          name: '/community/$communityName',
        ),
        builder: (context) => CommunityPage(
              communityName: communityName,
            )),
  );
}

void navigateToCommunityModeration(
  BuildContext context,
  String communityName,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(
        name: '/community/moderators/$communityName',
      ), //TODO: change to moderation page
      builder: (context) => CommunityPage(
        communityName: communityName,
      ),
    ),
  );
}
