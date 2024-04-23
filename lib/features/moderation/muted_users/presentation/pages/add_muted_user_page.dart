import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/widgets/unmute_mute_user.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    print("args $args");
    if (args != null) {
      isFirstFieldEditable = args['isFirstFieldEditable'];
      initialUsername = args['initialUsername'];
      initialModNotes = args['initialModNotes'];
      communityName = args['communityName'];
      _usernameController = TextEditingController(text: initialUsername);
      _modNotesController = TextEditingController(text: initialModNotes);
    } else {
      // Handle null arguments here
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
        title:
            isFirstFieldEditable ? Text('Mute User') : Text('Edit Muted User'),
        actions: [
          TextButton(
            onPressed: () {
              muteUser(context, _usernameController.text, communityName, 'mute',
                  _modNotesController.text);
              Navigator.pop(context);
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
