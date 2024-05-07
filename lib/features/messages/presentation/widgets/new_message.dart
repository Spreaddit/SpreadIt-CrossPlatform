import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';

class NewMessageForm extends StatefulWidget {
  @override
  State<NewMessageForm> createState() => _NewMessageFormState();
}

class _NewMessageFormState extends State<NewMessageForm> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? _validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a subject';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a message';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Container(
        color: Colors.white,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
                TextButton(
                  onPressed: () {
                    if (_validateForm()) {
                      String message = _messageController.text;
                      //TODO: send message logic
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'SEND',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 69, 172, 1.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixText: 'u/',
                border: InputBorder.none,
              ),
              validator: _validateUsername,
            ),
            Divider(
              thickness: 0.5,
              color: redditGrey,
            ),
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: InputBorder.none,
              ),
              validator: _validateSubject,
            ),
            Divider(
              thickness: 0.5,
              color: redditGrey,
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.3),
              child: TextFormField(
                controller: _messageController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: InputBorder.none,
                ),
                validator: _validateMessage,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    if (Form.of(context).validate()) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _usernameController.dispose();
    _subjectController.dispose();
    super.dispose();
  }
}

void showSendMessage(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Set to true to take up the entire screen height
    builder: (BuildContext context) {
      return NewMessageForm();
    },
  );
}
