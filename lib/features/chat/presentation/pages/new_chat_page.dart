import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:textfield_tags/textfield_tags.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final _stringTagController = StringTagController();

  CollectionReference messages = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextFieldTags<String>(
          textfieldTagsController: _stringTagController,
          initialTags: [],
          textSeparators: const [' ', ','],
          validator: (String tag) {
            //TODO: check if username exists in firebase
          },
          inputFieldBuilder: (context, inputFieldValues) {
            return TextField(
              controller: inputFieldValues.textEditingController,
              focusNode: inputFieldValues.focusNode,
            );
          }),
    );
  }
}
