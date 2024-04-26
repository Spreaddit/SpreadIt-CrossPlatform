import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatPage extends StatefulWidget {
  final String id;
  const ChatPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      if (message.uri.startsWith('http')) {
        // Open the Firebase storage URL in a browser or relevant application
        // You can use platform-specific plugins like url_launcher to achieve this
        // For example:
        // await launch(message.uri);
      }
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() {
    FirebaseFirestore.instance
        .collection('messages')
        .where('chatRoomId', isEqualTo: widget.id)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages = snapshot.docs.map((doc) {
          final data = doc.data();
          types.Message message = data['type'] == "text"
              ? types.TextMessage(
                  id: doc.id,
                  text: data['content'] ?? '',
                  author: types.User(
                    id: data['sender']['id'] ?? '',
                    imageUrl: data['sender']['avatarUrl'] ?? '',
                    lastName: data['sender']['name'] ?? '',
                  ),
                  createdAt: (data['time'] as Timestamp).millisecondsSinceEpoch,
                )
              : types.ImageMessage(
                  id: doc.id,
                  name: data['sender']['name'] ?? '',
                  uri: data['image'] ?? '',
                  size: 100,
                  author: types.User(
                    id: data['sender']['id'] ?? '',
                    imageUrl: data['sender']['avatarUrl'] ?? '',
                    lastName: data['sender']['name'] ?? '',
                  ),
                  createdAt: (data['time'] as Timestamp).millisecondsSinceEpoch,
                );
          return message;
        }).toList();
      });
    }, onError: (error) {
      print('Failed to load messages: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: _messages,
      onAttachmentPressed: _handleImageSelection,
      onMessageTap: _handleMessageTap,
      onPreviewDataFetched: _handlePreviewDataFetched,
      onSendPressed: _handleSendPressed,
      showUserAvatars: true,
      showUserNames: true,
      user: _user,
      theme: chatTheme,
    );
  }
}

ChatTheme chatTheme = const DefaultChatTheme(
    attachmentButtonIcon: Icon(Icons.image),
    deliveredIcon: Icon(Icons.done),
    documentIcon: Icon(Icons.insert_drive_file),
    errorIcon: Icon(Icons.error),
    inputBackgroundColor: Color(0xFFF5F6F8),
    inputSurfaceTintColor: Colors.white,
    inputMargin: EdgeInsets.all(8.0),
    inputPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    inputTextColor: Colors.black87,
    primaryColor: Color.fromARGB(255, 211, 0, 0),
    seenIcon: Icon(Icons.check_circle),
    dateDividerTextStyle: TextStyle(
      fontSize: 12,
      color: Colors.grey,
      decoration: TextDecoration.none,
    ),
    sendButtonIcon: Icon(Icons.send),
    emptyChatPlaceholderTextStyle: TextStyle(
      color: Colors.transparent,
      fontSize: 12,
      decoration: TextDecoration.none,
    ),
    userAvatarNameColors: [Colors.black],
    userNameTextStyle: TextStyle(
      fontSize: 12,
      decoration: TextDecoration.none,
    ),
    inputTextStyle: TextStyle(fontSize: 12),
    sentMessageBodyTextStyle: TextStyle(
        fontSize: 12,
        color: Colors.black,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal),
    receivedMessageBodyTextStyle: TextStyle(
        fontSize: 12,
        color: Colors.black,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal),
    systemMessageTheme: SystemMessageTheme(
      margin: EdgeInsets.all(8.0),
      textStyle: TextStyle(
        fontSize: 12,
        decoration: TextDecoration.none,
      ),
    ));
