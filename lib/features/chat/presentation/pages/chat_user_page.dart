import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/data/chatroom_model.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String userEmail = UserSingleton().user!.email!;

Widget _usersList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('chatrooms').snapshots(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        CustomSnackbar(content: "An Error Occured. Please Reload");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoaderWidget(
          dotSize: 10,
          logoSize: 100,
        );
      }
      return ListView(
        children: snapshot.data!.docs
            .map<Widget>(
              (doc) => _userItem(doc),
            )
            .toList(),
      );
    }),
  );
}

Widget _userItem(DocumentSnapshot document) {
  Chatroom data = Chatroom.fromDocumentSnapshot(
    document,
  );

  List<UserData> usersData = data.usersData;
  CircleAvatar avatar;

  String title;

  if (data.groupName != "") {
    title = data.groupName;
    avatar = CircleAvatar(
      child: Text(title[0]),
    );
  } else {
    UserData otherUser =
        usersData[0].email != userEmail ? usersData[0] : usersData[1];
    title = otherUser.name;
    avatar = CircleAvatar(
      backgroundImage: NetworkImage(otherUser.avatarUrl),
    );
  }

  return ListTile(
    leading: avatar,
    title: Text(title),
    subtitle: Text(data.lastMessage),
    trailing: Text(
      dateToDuration(data.timestamp),
    ),
    onTap: () {
      // Handle tap on the chat tile
    },
  );
}

class ChatUserPage extends StatefulWidget {
  const ChatUserPage({Key? key}) : super(key: key);

  @override
  State<ChatUserPage> createState() => _ChatUserPageState();
}

class _ChatUserPageState extends State<ChatUserPage> {
  @override
  Widget build(BuildContext context) {
    return _usersList();
  }
}
