import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_approved_users.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

/// Represents a card widget displaying information about an approved user.
///
/// This widget displays the username, avatar, and banner of the approved user
/// along with options to interact with the user like viewing profile and removing approval.
///
/// Required parameters:
/// - [username] : The username of the approved user.
/// - [communityName] : The name of the community to which the user belongs.
/// - [avatarUrl] : The URL of the user's avatar image.
/// - [banner] : The URL of the user's banner image.
/// - [onUnApprove] : Callback function invoked when the user is unapproved.
class ApprovedUserCard extends StatefulWidget {
  const ApprovedUserCard({
    Key? key,
    required this.username,
    required this.communityName,
    required this.avatarUrl,
    required this.banner,
    required this.onUnApprove,
  }) : super(key: key);

  final String username;
  final String communityName;
  final String avatarUrl;
  final String banner;
  final Function onUnApprove;

  @override
  State<ApprovedUserCard> createState() => _ApprovedUserCardState();
}

class _ApprovedUserCardState extends State<ApprovedUserCard> {
  String passedApproveLength = '';

  @override
  void initState() {
    super.initState();
  }

  void unApproveUser() async {
    var response = await removeApprovedUserRequest(
      communityName: widget.communityName,
      username: widget.username,
    );
    if (response == 200) {
      CustomSnackbar(content: "u/${widget.username} was removed").show(context);
      widget.onUnApprove();
    } else {
      CustomSnackbar(content: "Error removing user").show(context);
    }
  }

  void showApproveMenuSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //TODO INTEGRATE MESSAGING A USER W/FARIDA
              },
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text("Send Message"),
                trailing: Icon(Icons.arrow_forward_outlined),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //TODO INTEGRATE NAVIGATION TO USER PROFILE W/ MARIAM
                //TODO FIX THE "NULL" ERROR

                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(
                      name: '/user-profile/$widget.username',
                    ),
                    builder: (context) => UserProfile(
                      username: widget.username,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text("View profile"),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                showRemoveAlertDialog(context);
              },
              child: ListTile(
                leading: Icon(Icons.close_outlined, color: Colors.red),
                title: Text(
                  "Remove",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showRemoveAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove u/${widget.username}"),
          content: Text(
            "Are you sure you want to remove this user as an approved user?",
            softWrap: true,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[200],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () {
                unApproveUser();
                Navigator.of(context).pop();
              },
              child: Text(
                "Remove",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: TextButton(
        onPressed: () {
          //TODO INTEGRATE NAVIGATION TO USER PROFILE W/ MARIAM
          //TODO FIX THE "NULL" ERROR

          Navigator.of(context).push(
            MaterialPageRoute(
              settings: RouteSettings(
                name: '/user-profile/$widget.username',
              ),
              builder: (context) => UserProfile(
                username: widget.username,
              ),
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showApproveMenuSheet(context);
            },
          ),
          title: Text("u/${widget.username}"),
        ),
      ),
    );
  }
}
