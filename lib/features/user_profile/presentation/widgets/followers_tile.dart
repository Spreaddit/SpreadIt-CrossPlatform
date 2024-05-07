import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/follow_unfollow_api.dart';

/// A tile widget representing a follower in a list.
///
/// This widget displays information about a follower, including their username
/// and avatar. It also provides the functionality to follow or unfollow the user.
///
/// Example usage:
/// ```dart
/// FollowerListTile(
///   username: 'example_username',
///   avatarUrl: 'https://example.com/avatar.png',
///   isFollowed: true,
/// )
/// ```
class FollowerListTile extends StatefulWidget {
  /// The username of the follower.
  final String username;

  /// The URL of the follower's avatar image.
  final String avatarUrl;

  /// Indicates whether the current user is following this follower.
  final bool isFollowed;

  /// Constructs a [FollowerListTile] with the given parameters.
  FollowerListTile({
    required this.username,
    required this.avatarUrl,
    required this.isFollowed,
  });

  @override
  _FollowerListTileState createState() => _FollowerListTileState();
}

class _FollowerListTileState extends State<FollowerListTile> {
  /// Indicates the current follow status.
  bool followStatus = false;

  @override
  void initState() {
    super.initState();
    followStatus = widget.isFollowed;
  }

  /// Toggles the follow status of the user.
  Future<void> unfollowOrFollow() async {
    try {
      var response = await toggleFollow(
        isFollowing: followStatus,
        username: widget.username,
      );
      if (response == 200) {
        setState(() {
          followStatus = !followStatus;
        });
      } else if (response == 400) {
        CustomSnackbar(content: 'Username is required').show(context);
      } else if (response == 404) {
        CustomSnackbar(content: 'User not found').show(context);
      } else if (response == 500) {
        CustomSnackbar(content: "An error ocuured please try again later")
            .show(context);
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
        trailing: MouseRegion(
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
