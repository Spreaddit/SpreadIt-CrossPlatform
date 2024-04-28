import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/new_chat_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uuid/uuid.dart';

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
  late types.User _user;

  @override
  void initState() {
    super.initState();
    _user = types.User(
      metadata: {
        'email': UserSingleton().user!.email,
      },
      // id: UserSingleton().user!.firebaseId,
      id: userId,
      imageUrl: UserSingleton().user!.avatarUrl,
      lastName: UserSingleton().user!.username,
    );
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

    Map<String, dynamic> messageMap = {
      'chatRoomId': widget.id,
      'content': textMessage.text,
      'image': '',
      'sender': {
        'avatarUrl': _user.imageUrl ?? "",
        'email': _user.metadata!['email'],
        'id': _user.id,
        'name': _user.lastName ?? '',
      },
      'time': Timestamp.now(),
      'type': 'text',
    };

    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');

    CollectionReference chatrooms =
        FirebaseFirestore.instance.collection('chatrooms');

    messages.add(messageMap).then((value) => print("Message sent")).catchError(
          (error) => print("Failed to send message"),
        );

    chatrooms.doc(widget.id).update(
      {'lastMessage': textMessage.text},
    );
    chatrooms.doc(widget.id).update(
      {'timestamp': messageMap['time']},
    );
  }

  void _loadMessages() {
    FirebaseFirestore.instance
        .collection('messages')
        .where('chatRoomId', isEqualTo: widget.id)
        .orderBy('time', descending: false)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages = snapshot.docs
            .map((doc) {
              print((doc.data()['time'] as Timestamp)
                  .millisecondsSinceEpoch
                  .toString());
              final data = doc.data();
              String email = data['sender']['email'];
              types.Message message = data['type'] == "text"
                  ? types.TextMessage(
                      id: doc.id,
                      text: data['content'] ?? '',
                      author: types.User(
                        metadata: {
                          'email': email,
                        },
                        id: data['sender']['id'] ?? '',
                        imageUrl: data['sender']['avatarUrl'] ?? '',
                        lastName: data['sender']['name'] ?? '',
                      ),
                      createdAt:
                          (data['time'] as Timestamp).millisecondsSinceEpoch,
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
                      createdAt:
                          (data['time'] as Timestamp).millisecondsSinceEpoch,
                    );
              return message;
            })
            .toList()
            .reversed
            .toList();
      });
    }, onError: (error) {
      CustomSnackbar(content: "Failed to display messages");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Chat(
        messages: _messages,
        onAttachmentPressed: _handleImageSelection,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        dateHeaderThreshold: 200000,
        showUserNames: true,
        user: _user,
        theme: chatTheme,
        imageMessageBuilder: imageMessageBuilder,
      ),
    );
  }
}

Widget Function(types.ImageMessage, {required int messageWidth})?
    imageMessageBuilder = (message, {required int messageWidth}) {
  return FadeInImage.memoryNetwork(
    placeholder: kTransparentImage,
    image: message.uri,
    width: messageWidth.toDouble(),
    fit: BoxFit.cover,
  );
};

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
    seenIcon: Icon(Icons.check_circle),
    primaryColor: redditGrey,
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
      fontWeight: FontWeight.bold,
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
