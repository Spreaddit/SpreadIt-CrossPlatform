import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
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
  final String chatroomName;
  const ChatPage({
    Key? key,
    required this.id,
    required this.chatroomName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  late types.User _user;
  bool isUploading = false;
  bool isMuted = false; //TODO: change accoridng to mariam's settings

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
    File? image;
    bool isResult = false;
    setState(() {
      isUploading = true;
    });

    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      isResult = true;
      image = File(imagePicked.path);
    }

    if (!isResult) return;

    final message = types.ImageMessage(
      author: _user,
      name: imagePicked!.name,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      size: 100,
      uri: image!.path,
    );

    final metadata = SettableMetadata(contentType: "image/jpeg");

    final storageRef =
        FirebaseStorage.instance.ref().child('images/${message.id}');

    String imageUrl = '';

    kIsWeb
        ? storageRef
            .putData(
            await imagePicked.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
            .whenComplete(() async {
            await storageRef.getDownloadURL().then((value) {
              imageUrl = value;
              setState(() {
                isUploading = false;
              });
            });
          })
        : storageRef.putFile(image, metadata).whenComplete(() async {
            await storageRef.getDownloadURL().then((value) {
              imageUrl = value;
              setState(() {
                isUploading = false;
              });
            });

            while (isUploading) {}

            _addMessage(message);

            print("image url $imageUrl");

            Map<String, dynamic> messageMap = {
              'chatRoomId': widget.id,
              'content': "",
              'image': imageUrl,
              'sender': {
                'avatarUrl': _user.imageUrl ?? "",
                'email': _user.metadata!['email'],
                'id': _user.id,
                'name': _user.lastName ?? '',
              },
              'time': Timestamp.now(),
              'type': 'image',
            };

            CollectionReference messages =
                FirebaseFirestore.instance.collection('messages');

            messages
                .add(messageMap)
                .then((value) => print("Message sent"))
                .catchError(
                  (error) => print("Failed to send message"),
                );
          }).catchError((error) {
            print('Error uploading image: $error');
          });
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

  void deleteMessage(String messageId, MessageType type, String? imageUrl) {
    void deleteMessageFromFirebase() {
      FirebaseFirestore.instance.collection('messages').doc(messageId).delete();
    }

    if (type == MessageType.image) {
      FirebaseStorage.instance.refFromURL(imageUrl!).delete();
    }

    void updateLatestMessage() {
      CollectionReference chatrooms =
          FirebaseFirestore.instance.collection('chatrooms');

      types.Message? lastMessage = _messages.first;
      String lastMessageContent;
      if (lastMessage.id == messageId) {
        print(_messages.length);
        if (_messages.length == 1) {
          lastMessageContent = "";
          lastMessage = null;
        } else {
          types.Message lastMessage = _messages[1];
          if (lastMessage is types.TextMessage) {
            lastMessageContent = lastMessage.text;
          } else {
            lastMessageContent = "image";
          }
        }

        chatrooms.doc(widget.id).update(
          {'lastMessage': lastMessageContent},
        );
        chatrooms.doc(widget.id).update(
          {
            'timestamp': lastMessage == null
                ? Timestamp.now()
                : Timestamp.fromMillisecondsSinceEpoch(lastMessage.createdAt!)
          },
        );
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Message',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content:
            Text('Are you sure you want to delete this message for everyone?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete Message'),
            onPressed: () {
              Navigator.of(context).pop();
              updateLatestMessage();
              deleteMessageFromFirebase();
            },
          ),
        ],
      ),
    );
  }

  void copyMessage(String? messageText) {
    if (messageText != null) {
      Clipboard.setData(
        ClipboardData(
          text: messageText,
        ),
      );
      CustomSnackbar(content: "Message copied to clipboard").show(context);
    } else {
      CustomSnackbar(content: "Failed to copy message to clipboard")
          .show(context);
    }
  }

  void onMessageLongPress({
    required BuildContext context,
    required types.Message message,
  }) {
    if (message.author.id == userId) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (message is types.TextMessage)
                ListTile(
                  leading: Icon(Icons.copy),
                  title: Text("Copy Message"),
                  onTap: () {
                    Navigator.of(context).pop();
                    copyMessage(message.text);
                  },
                ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete Message"),
                onTap: () {
                  Navigator.of(context).pop();
                  deleteMessage(message.id, message.type,
                      message is types.ImageMessage ? message.uri : null);
                },
              ),
            ],
          ),
        ),
      );
      return;
    }

    if (message is types.TextMessage) {
      copyMessage(message.text);
    }
  }

  void showChatroomOptions() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(Icons.alarm_off),
                title: Text(
                    isMuted ? "Unmute Notifications" : "Mute Notifications"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ));
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
          title: Text(
            widget.chatroomName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showChatroomOptions();
              },
              icon: Icon(Icons.more_horiz),
            )
          ]),
      body: Chat(
        messages: _messages,
        isAttachmentUploading: isUploading,
        onAttachmentPressed: _handleImageSelection,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        dateHeaderThreshold: 200000,
        showUserNames: true,
        user: _user,
        theme: chatTheme,
        imageMessageBuilder: imageMessageBuilder,
        onMessageLongPress: (context, message) => onMessageLongPress(
          context: context,
          message: message,
        ),
        onMessageDoubleTap: (context, message) => onMessageLongPress(
          context: context,
          message: message,
        ),
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
    height: messageWidth.toDouble(),
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
