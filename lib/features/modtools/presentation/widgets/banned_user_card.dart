import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_banned_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_edit_banned_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

class BannedUserCard extends StatefulWidget {
  BannedUserCard({
    Key? key,
    required this.username,
    required this.communityName,
    required this.violation,
    required this.banReason,
    required this.days,
    required this.messageToUser,
    required this.bannedDate,
    required this.avatarUrl,
    required this.onUnban,
    required this.onRequestCompleted,
  }) : super(key: key);

  final String username;
  final String communityName;
  final String violation;
  final String banReason;
  final int days;
  final String messageToUser;
  final String bannedDate;
  final String avatarUrl;
  final Function onUnban;
  final Function onRequestCompleted;

  @override
  State<BannedUserCard> createState() => _BannedUserCardState();
}

class _BannedUserCardState extends State<BannedUserCard> {
  String passedBanLength = '';

  @override
  void initState() {
    super.initState();
    String banLength = widget.bannedDate.replaceAll('Z', '');
    Duration banDuration = DateTime.parse(DateTime.now().toString())
        .difference(DateTime.parse(banLength));

    if (banDuration.inDays > 0) {
      passedBanLength = '${banDuration.inDays}d';
    } else if (banDuration.inHours > 0) {
      passedBanLength = '${banDuration.inHours}h';
    } else if (banDuration.inMinutes > 0) {
      passedBanLength = '${banDuration.inMinutes}m';
    } else {
      passedBanLength = 'Now';
    }
  }

  void unbanUser() async {
    var response = await unbanUserRequest(
      communityName: widget.communityName,
      username: widget.username,
    );
    if (response == 200) {
      CustomSnackbar(content: "u/${widget.username} was unbanned")
          .show(context);
      widget.onUnban();
    } else {
      CustomSnackbar(content: "Error unbanning user").show(context);
    }
  }

  void showBanMenuSheet(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrEditBannedPage(
                      communityName: widget.communityName,
                      isAdding: false,
                      username: widget.username,
                      violation: widget.violation,
                      banReason: widget.banReason,
                      days: widget.days,
                      messageToUser: widget.messageToUser,
                      onRequestCompleted: widget.onRequestCompleted,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text("See details"),
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
                showUnbanAlertDialog(context);
              },
              child: ListTile(
                leading: Icon(Icons.hardware, color: Colors.red),
                title: Text(
                  "Unban",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showUnbanAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Unban User"),
          content: Text("Are you sure you want to unban this user?"),
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
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                unbanUser();
                Navigator.of(context).pop();
              },
              child: Text(
                "Unban",
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
              showBanMenuSheet(context);
            },
          ),
          title: Text("u/${widget.username}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$passedBanLength • ${widget.violation}',
                softWrap: true,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
