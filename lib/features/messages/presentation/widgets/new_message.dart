import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/messages/data/handle_message_data.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';

class NewMessageForm extends StatefulWidget {
  final String? messageId;
  final void Function(MessageModel message) setNewMessage;
  final void Function(MessageModel message)? setNewMessageInner;
  NewMessageForm({
    this.messageId,
    required this.setNewMessage,
    this.setNewMessageInner,
  });

  @override
  State<NewMessageForm> createState() => _NewMessageFormState();
}

class _NewMessageFormState extends State<NewMessageForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String subject = _subjectController.text;
      String message = _messageController.text;
      var value = await sendMessage(
          username: username,
          subject: subject,
          messageId: widget.messageId,
          message: message);

      if (value != null) {
        widget.setNewMessage(value);
        if (widget.messageId != null) {
          print("ANaaaa ahooo");
          widget.setNewMessageInner!(value);
        }
      } else {
        CustomSnackbar(content: "Error sending message").show(context);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.4),
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
                      _submitForm();
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
              if (widget.messageId == null)
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixText: 'u/',
                    border: InputBorder.none,
                  ),
                  validator: _validateUsername,
                ),
              if (widget.messageId == null)
                Divider(
                  thickness: 0.5,
                  color: redditGrey,
                ),
              if (widget.messageId == null)
                TextFormField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    border: InputBorder.none,
                  ),
                  validator: _validateSubject,
                ),
              if (widget.messageId == null)
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
              IconButton(
                onPressed: () {
                  _showLinkBuilder(context);
                },
                icon: Icon(Icons.link),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLinkBuilder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LinkBuilderForm(messageController: _messageController);
      },
    );
  }

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
}

class LinkBuilderForm extends StatelessWidget {
  final TextEditingController messageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController linkMessageController = TextEditingController();

  LinkBuilderForm({required this.messageController});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: linkMessageController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Link name',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a link name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: linkController,
                decoration: InputDecoration(
                  labelText: 'Link',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a link';
                  }
                  if (validateLink(value)) {
                    return 'Invalid link format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String linkName = '[${linkMessageController.text}]';
                    String link = '(${linkController.text})';
                    String finalLink = '$linkName $link';

                    messageController.text =
                        '${messageController.text} $finalLink';

                    linkController.clear();
                    linkMessageController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Insert Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSendMessage({
  required BuildContext context,
  String? messageId,
  required final void Function(MessageModel message) setNewMessage,
  final void Function(MessageModel message)? setNewMessageInner,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return NewMessageForm(
          messageId: messageId,
          setNewMessage: setNewMessage,
          setNewMessageInner: setNewMessageInner);
    },
  );
}
