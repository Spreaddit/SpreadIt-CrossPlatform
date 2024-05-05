import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/follow_unfollow_api.dart';

class FollowerListTile extends StatefulWidget {
  final String username;
  final String avatarUrl;
  final bool isFollowed;

  FollowerListTile({
    required this.username,
    required this.avatarUrl,
    required this.isFollowed,
  });

  @override
  _FollowerListTileState createState() => _FollowerListTileState();
}

class _FollowerListTileState extends State<FollowerListTile> {
  bool followStatus = false;

  @override
  void initState() {
    super.initState();
    followStatus = widget.isFollowed;
  }

  Future<void> unfollowOrFollow() async {
    try {
      var response = await toggleFollow(
          isFollowing: followStatus, username: widget.username);
      if (response == 200) {
        setState(() {
          followStatus = !followStatus;
        });
      } else if (response == 400) {
        CustomSnackbar(content: 'Username is required').show(context);
      } else if (response == 404) {
        CustomSnackbar(content: 'User not found').show(context);
      } else if (response == 500) {
        CustomSnackbar(content: 'Internal server error').show(context);
      }
    } catch (e) {
      print('Error toggling follow status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/user-profile',
          arguments: {
            'username': widget.username,
          },
        );
      },
      child: ListTile(
        tileColor: Colors.white,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.avatarUrl),
        ),
        title: Text(widget.username),
        subtitle: Text(widget.username),
        trailing:  MouseRegion(
        cursor: SystemMouseCursors.basic,
        onHover: (_) {},
        child: TextButton(
          onPressed: () async {
            await unfollowOrFollow();
          },
          child: Text(
            followStatus ? 'Following' : 'Follow',
            style: TextStyle(
              color: followStatus ? Colors.grey : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      ),
    );
  }
}
