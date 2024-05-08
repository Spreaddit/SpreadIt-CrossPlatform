import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/get_permissions.dart';
import 'package:spreadit_crossplatform/features/community/data/mod_permissions.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/moderators/data/invite_moderator.dart';

/// Shows a modal bottom sheet to invite a moderator to a community.
///
/// This function displays a modal bottom sheet where the user can choose a
/// community to invite a moderator, select the moderator's permissions, and
/// send the invitation message.
///
/// Parameters:
/// - `context`: The build context.
/// - `communities`: A list of communities to choose from.
/// - `username`: The username of the moderator being invited.

void showModalBottomSheetInvite(
    BuildContext context, List<Community> communities, String username) {
  Community _selectedCommunity = communities.first;
  bool _managePostsClicked = false;
  bool _manageUsersClicked = false;
  bool _manageSettingsClicked = false;
  late TextEditingController _messageController = TextEditingController(
      text: 'I invite you to be a moderator of r/${_selectedCommunity.name}');
  late ModPermissions? permissions = ModPermissions(
      manageUsers: false, manageSettings: false, managePostsAndComments: false);

  @override
  void dispose() {
    _messageController.dispose();
  }

  Future<void> checkPermissions() async {
    permissions = await fetchPermissionsData(_selectedCommunity.name, username);
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose a community:',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: communities.map((community) {
                      bool isSelected = _selectedCommunity == community;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () async {
                            await checkPermissions();
                            setState(() {
                              _selectedCommunity = community;
                              _messageController = TextEditingController(
                                  text:
                                      'I invite you to be a moderator of r/${community.name}');

                              if (permissions!.manageUsers == false) {
                                Navigator.pop(context);
                                CustomSnackbar(
                                        content:
                                            "You dont't have permission to invite users to r/${community.name}")
                                    .show(context);
                              }
                            });
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                backgroundImage: NetworkImage(community.image!),
                                child: CircleAvatar(
                                  radius: isSelected ? 25 : 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(community.image!),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.transparent,
                                        width: isSelected ? 4.0 : 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(community.name!),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                if (_selectedCommunity != null) ...[
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _managePostsClicked = !_managePostsClicked;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return _managePostsClicked
                                  ? Colors.blue
                                  : Colors.grey;
                            },
                          ),
                        ),
                        child: Text('Manage posts and comments'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _manageUsersClicked = !_manageUsersClicked;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return _manageUsersClicked
                                  ? Colors.blue
                                  : Colors.grey;
                            },
                          ),
                        ),
                        child: Text('Manage users'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _manageSettingsClicked = !_manageSettingsClicked;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return _manageSettingsClicked
                                  ? Colors.blue
                                  : Colors.grey;
                            },
                          ),
                        ),
                        child: Text('Manage settings'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController, // Set controller here
                          onChanged: (value) {
                            setState(() {}); // Update UI when text changes
                          },
                          decoration: InputDecoration(
                            hintText: 'Type your message here...',
                            labelText: 'Message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton.icon(
                        onPressed: _messageController.text.isNotEmpty &&
                                (_managePostsClicked ||
                                    _manageUsersClicked ||
                                    _manageSettingsClicked)
                            ? () {
                                print(_messageController.text);
                                print(_managePostsClicked);
                                print(_manageUsersClicked);
                                print(_manageSettingsClicked);
                                print(_selectedCommunity.name);
                                inviteModerator(
                                    communityName: _selectedCommunity.name,
                                    username: username,
                                    managePostsAndComments: _managePostsClicked,
                                    manageUsers: _manageUsersClicked,
                                    manageSettings: _manageSettingsClicked);
                                Navigator.pop(context);
                                CustomSnackbar(
                                        content: "Invitaion sent successfully!")
                                    .show(context);
                              }
                            : () {
                                Navigator.pop(context);
                                CustomSnackbar(content: "Invalid invite!")
                                    .show(context);
                              },
                        icon: Icon(Icons.send),
                        label: Text('Send'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return _messageController.text.isNotEmpty
                                ? Colors.blue
                                : Colors.grey;
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      );
    },
  );
}
