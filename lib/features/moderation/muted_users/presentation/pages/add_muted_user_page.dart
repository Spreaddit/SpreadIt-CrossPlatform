import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/muted_user_class_model.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/widgets/unmute_mute_user.dart';

/// A page for editing or muting a user within a community.
///
/// This page provides a form for moderators to edit or mute a user within a community. 
/// Moderators can set a username, add or edit moderator notes about why the user 
/// was muted, and then save the changes. The page provides a text field for entering 
/// the username and a text area for adding or editing moderator notes. The moderator 
/// notes are not visible to the user.
///
/// This page is typically used within a navigation stack, allowing moderators to access 
/// it when they need to perform user moderation actions.
///
/// The page expects the following arguments to be passed to it:
///
/// - `isFirstFieldEditable`: A boolean indicating whether the username field is editable. 
///   If `true`, the username field is editable, allowing for muting a new user. If `false`, 
///   the username field is read-only, indicating that the page is being used to edit 
///   an existing muted user.
///
/// - `mutedUser`: An optional `MutedUser` object representing the user being edited or muted. 
///   If provided, the username and moderator notes fields will be pre-filled with the 
///   user's existing information.
///
/// - `communityName`: A string representing the name of the community to which the user 
///   belongs. This information may be displayed or used internally for context.
///
/// - `onUpdate`: A callback function that takes a `MutedUser` object as a parameter. 
///   This function is called when the user information is updated and can be used to 
///   notify the parent widget or perform additional actions.
///
/// Example usage:
///
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => EditMutedUserPage(
///       isFirstFieldEditable: true,
///       mutedUser: existingMutedUser,
///       communityName: 'Sample Community',
///       onUpdate: (updatedUser) {
///         // Handle updated user information
///       },
///     ),
///   ),
/// );
/// ```

class EditMutedUserPage extends StatefulWidget {
  @override
  _EditMutedUserPageState createState() => _EditMutedUserPageState();
}

class _EditMutedUserPageState extends State<EditMutedUserPage> {
  late TextEditingController _usernameController;
  late TextEditingController _modNotesController;
  late bool isFirstFieldEditable;
  late String initialUsername;
  late String initialModNotes;
  late String communityName;
  late void Function(MutedUser)? onUpdate;
  late MutedUser? mutedUser;

  @override
  void initState() {
    super.initState();
    isFirstFieldEditable = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      isFirstFieldEditable = args['isFirstFieldEditable'] ?? true;
      mutedUser = args['mutedUser'];
      initialUsername = '';
      initialModNotes = '';
      if (mutedUser != null) {
        initialUsername = mutedUser!.username;
        initialModNotes = mutedUser!.note;
      }
      communityName = args['communityName'] ?? '';
      onUpdate = args['onUpdate'];
      _usernameController = TextEditingController(text: initialUsername);
      _modNotesController = TextEditingController(text: initialModNotes);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _modNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (!isFirstFieldEditable) {
              Navigator.pop(context);
            }
            Navigator.pop(context);
          },
        ),
        title: isFirstFieldEditable
            ? Text('Mute User')
            : Text('Edit Muted User'),
        actions: [
          TextButton(
            onPressed: () {
              muteUser(
                context,
                _usernameController.text,
                communityName,
                'mute',
                _modNotesController.text,
                isFirstFieldEditable,
              );
              if (!isFirstFieldEditable) {
                mutedUser!.note = _modNotesController.text;
                onUpdate!(mutedUser!);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: TextFormField(
                controller: _usernameController,
                readOnly: !isFirstFieldEditable,
                decoration: InputDecoration(
                  prefix: Text(
                    'u/',
                    style: TextStyle(color: Colors.black),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Enter username',
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Mod note about why they were muted',
            ),
            SizedBox(height: 10.0),
            Text(
              'Not visible to user',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: TextFormField(
                controller: _modNotesController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Enter moderator notes',
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
