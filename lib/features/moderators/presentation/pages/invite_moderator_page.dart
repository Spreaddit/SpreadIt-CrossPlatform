import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_bar.dart';
import 'package:spreadit_crossplatform/features/moderators/data/delete_moderator.dart';
import 'package:spreadit_crossplatform/features/moderators/data/get_moderators.dart';
import 'package:spreadit_crossplatform/features/moderators/data/invite_moderator.dart';
import 'package:spreadit_crossplatform/features/moderators/data/moderator_class_model.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/edit_moderators_permissions.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../../../homepage/presentation/widgets/date_to_duration.dart';

/// A StatefulWidget for inviting a moderator to a community.
class InviteModeratorPage extends StatefulWidget {
  /// The name of the community to invite the moderator to.
  String communityName;

  /// Constructs an InviteModeratorPage with the given [communityName].
  InviteModeratorPage({
    required this.communityName,
  });

  @override
  State<InviteModeratorPage> createState() {
    return _InviteModeratorPageState();
  }
}

/// The state class associated with InviteModeratorPage.
class _InviteModeratorPageState extends State<InviteModeratorPage> {
  late TextEditingController _usernameController;
  late bool managePostsAndComments;
  late bool manageUsers;
  late bool manageSettings;
  bool _textFieldEnabled = false;
  bool _buttonState = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    managePostsAndComments = true;
    manageUsers = true;
    manageSettings = true;

    _usernameController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      _buttonState = _usernameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Moderator'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _textFieldEnabled = true;
                });
              },
              child: AbsorbPointer(
                absorbing: !_textFieldEnabled,
                child: TextField(
                  controller: _usernameController,
                  enabled: _textFieldEnabled,
                  decoration: InputDecoration(
                    prefixText: 'u/',
                    labelText: 'Enter Username',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          ),
          CheckboxListTile(
            title: Text("Manage Posts and Comments"),
            value: managePostsAndComments,
            onChanged: (newValue) {
              setState(() {
                managePostsAndComments = newValue!;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Manage Users"),
            value: manageUsers,
            onChanged: (newValue) {
              setState(() {
                manageUsers = newValue!;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Manage Settings"),
            value: manageSettings,
            onChanged: (newValue) {
              setState(() {
                manageSettings = newValue!;
              });
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 16.0),
        child: Button(
          onPressed: _buttonState
              ? () {
                  String userToInvite = _usernameController.text;
                  print("username :$userToInvite");
                  inviteModerator(
                      communityName: widget.communityName,
                      username: userToInvite,
                      managePostsAndComments: managePostsAndComments,
                      manageUsers: manageUsers,
                      manageSettings: manageSettings);
                  Navigator.pop(context);
                }
              : null,
          text: 'Add',
          backgroundColor: _buttonState ? Colors.blue : Color(0xFFEFEFED),
          foregroundColor:
              _buttonState ? Colors.white : Color.fromARGB(255, 113, 112, 112),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
