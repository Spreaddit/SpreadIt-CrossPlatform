import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/messages/data/handle_message_data.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';

/// Method to show send message modal
///
/// This method displays a modal bottom sheet containing a form for sending a new message. It provides a convenient way to gather user input for sending messages.
///
/// Example usage:
/// ```dart
/// showSendMessage(
///   context: context,
///   setNewMessage: (message) {
///     // Handle setting the new message here
///   },
/// );
/// ```
///
/// Parameters:
/// - `context`: The build context from the calling widget.
/// - `messageId`: (Optional) The ID of the message if it's a reply to an existing message.
/// - `setNewMessage`: A callback function that takes a `MessageModel` object and handles setting the new message.
/// - `setNewMessageInner`: (Optional) A callback function that takes a `MessageModel` object and handles setting the new inner message if `messageId` is not null.
/// Define a stateful widget for a new message form
class NewMessageForm extends StatefulWidget {
  final String? messageId;
  final void Function(MessageModel message) setNewMessage;
  final void Function(MessageModel message)? setNewMessageInner;

  /// Constructor for NewMessageForm
  NewMessageForm({
    this.messageId,
    required this.setNewMessage,
    this.setNewMessageInner,
  });

  @override
  State<NewMessageForm> createState() => _NewMessageFormState();
}

/// State class for the NewMessageForm widget
class _NewMessageFormState extends State<NewMessageForm> {
  /// Global key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controllers for handling input fields
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  /// Function to submit the form
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      /// Extracting values from input fields
      String username = _usernameController.text;
      String subject = _subjectController.text;
      String message = _messageController.text;

      /// Send message and get the response
      var value = await sendMessage(
          username: username,
          subject: subject,
          messageId: widget.messageId,
          message: message);

      /// If response is not null, update message
      if (value != null) {
        widget.setNewMessage(value);

        /// If messageId is not null, update inner message
        if (widget.messageId != null) {
          widget.setNewMessageInner!(value);
        }
      } else {
        /// Show error message if sending message fails
        CustomSnackbar(content: "Error sending message").show(context);
      }

      /// Close the form
      Navigator.pop(context);
    }
  }

  /// Build method for the widget
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
              /// Close button and Send button
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

              /// Username input field
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

              /// Subject input field
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

              /// Message input field
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

              /// Button to show link builder
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

  /// Method to show link builder modal
  void _showLinkBuilder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LinkBuilderForm(messageController: _messageController);
      },
    );
  }

  /// Validation method for username field
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  /// Validation method for subject field
  String? _validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a subject';
    }
    return null;
  }

  /// Validation method for message field
  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a message';
    }
    return null;
  }
}

/// Widget for the link builder form
class LinkBuilderForm extends StatelessWidget {
  final TextEditingController messageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController linkMessageController = TextEditingController();

  /// Constructor for LinkBuilderForm
  LinkBuilderForm({required this.messageController});

  /// Build method for the widget
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
              /// Input field for link name
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

              /// Input field for link URL
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

              /// Button to insert link into message
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

/// Method to show send message modal
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
