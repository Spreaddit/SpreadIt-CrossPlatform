import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/muted_user_class_model.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/widgets/unmute_mute_user.dart';
/// A tile widget representing a muted user within a community.
///
/// This tile widget displays information about a muted user, including their username,
/// profile picture, mute date, and moderator note. It provides options for moderators
/// to view details, view the user's profile, and unmute the user.
///
/// The tile includes a leading circle avatar displaying the user's profile picture,
/// a title showing the username, and a subtitle showing the mute date and moderator note.
/// It also includes a trailing icon button for showing additional options in a bottom sheet.
///
/// This tile is typically used within a list view to display a list of muted users.
///
/// Example usage:
///
/// ```dart
/// MutedUserTile(
///   mutedUser: mutedUser,
///   onTap: () {
///     // Handle tap event
///   },
///   communityName: 'Sample Community',
///   onUnmute: () {
///     // Handle unmute event
///   },
///   onUpdate: (updatedUser) {
///     // Handle update event
///   },
/// );
/// ```
/// 
class MutedUserTile extends StatelessWidget {
  final MutedUser mutedUser;
  final VoidCallback onTap;
  final String communityName;
  final VoidCallback onUnmute;
  final void Function(MutedUser) onUpdate;

  const MutedUserTile({
    required this.mutedUser,
    required this.onTap,
    required this.communityName,
    required this.onUnmute,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(mutedUser.userProfilePic),
          ),
          title: Text("u/${mutedUser.username}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${mutedUser.date}  •  ${mutedUser.note}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomBottomSheet(
                    icons: [
                      Ionicons.pencil_outline,
                      CupertinoIcons.person_alt_circle,
                      CupertinoIcons.bell_slash,
                    ],
                    text: [
                      "See Details",
                      "View Profile",
                      "Unmute",
                    ],
                    onPressedList: [
                      () {
                        Navigator.pushNamed(
                          context,
                          '/edit-muted-user',
                          arguments: {
                            'isFirstFieldEditable': false,
                            'communityName': communityName,
                            'onUpdate' : onUpdate,
                            'mutedUser' :mutedUser,
                          },
                        );
                      },
                      () {
                        Navigator.of(context).pushNamed(
                          '/user-profile',
                          arguments: {
                            'username':mutedUser.username,
                          },
                        );
                      },
                      () {
                        muteUser(context, mutedUser.username, communityName,'unmute', '', true);
                        onUnmute();
                      },
                    ],
                    onTrailingPressedList: [
                    () {
                        Navigator.pushNamed(
                          context,
                          '/edit-muted-user',
                          arguments: {
                            'isFirstFieldEditable': false,
                            'initialUsername': "u/${mutedUser.username}",
                            'initialModNotes': mutedUser.note,
                            'communityName': communityName,
                            
                          },
                        );
                      },
                    ],
                    trailingIcons: [
                      Icons.arrow_forward,
                      null,
                      null,
                    ],
                    colors: [
                      null,
                      null,
                      Colors.red, // Setting the color of the last item to red
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
