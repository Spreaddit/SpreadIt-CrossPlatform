import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/muted_user_class_model.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/widgets/unmute_mute_user.dart';
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
