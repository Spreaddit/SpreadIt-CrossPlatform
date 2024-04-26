import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/data/chatroom_model.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';

// String userId = UserSingleton().user!.id;
String userId = 'ZfVwjS49NshSBOFe1Yy124MHUh22';

Widget _usersList(int selectedOption) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('chatrooms')
        .where('users', arrayContains: userId)
        .snapshots(),
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
            .where((element) {
              if (selectedOption == 1) {
                return element['groupname'] != '';
              } else if (selectedOption == 2) {
                return element['groupname'] == '';
              }
              return true;
            })
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
      child: Text(
        title[0].toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } else {
    UserData otherUser = data.users[0] != userId ? usersData[0] : usersData[1];
    title = otherUser.name;
    avatar = CircleAvatar(
      backgroundImage: NetworkImage(otherUser.avatarUrl),
    );
  }

  return ListTile(
    leading: avatar,
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(data.lastMessage),
    trailing: Text(
      dateToDuration(data.timestamp),
    ),
    onTap: () {
      // Handle tap on the chat tile
    },
  );
}

Widget floatingNewChatButton() {
  return FloatingActionButton(
    onPressed: () {
      print('Floating button pressed!');
    },
    child: Icon(Icons.chat_bubble),
  );
}

class ChatUserPage extends StatefulWidget {
  final int selectedOption;
  const ChatUserPage({
    Key? key,
    this.selectedOption = 3,
  }) : super(key: key);

  @override
  State<ChatUserPage> createState() => _ChatUserPageState();
}

class _ChatUserPageState extends State<ChatUserPage> {
  late int selectedOption;
  @override
  void initState() {
    setState(() {
      selectedOption = widget.selectedOption;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatUserPage oldWidget) {
    setState(() {
      selectedOption = widget.selectedOption;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(selectedOption);
    return _usersList(selectedOption);
  }
}
