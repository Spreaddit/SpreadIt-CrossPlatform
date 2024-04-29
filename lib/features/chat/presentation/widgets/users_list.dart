import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spreadit_crossplatform/features/chat/data/chatroom_model.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/mute_chat.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/navigate_to_chat.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';

// String userId = UserSingleton().user!.firebaseId;
String userId = 'KMmoAXLiVc9UBl0rNqTO';

Widget usersList({
  required BuildContext context,
  required selectedOption,
}) {
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
                return element['groupName'] == '';
              } else if (selectedOption == 2) {
                return element['groupName'] != '';
              }
              return true;
            })
            .mapIndexed<Widget>(
              (index, doc) => Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) =>
                            muteNotifications(context, doc.id),
                        backgroundColor: Color.fromARGB(255, 179, 179, 179),
                        foregroundColor: Colors.white,
                        icon: getIsMuted(doc.id)
                            ? Icons.alarm_on
                            : Icons.alarm_off,
                        label: getIsMuted(doc.id) ? "UnMute" : "Mute",
                      ),
                    ],
                  ),
                  child: _userItem(
                    docId: doc.id,
                    document: doc,
                    context: context,
                  )),
            )
            .toList(),
      );
    }),
  );
}

Widget _userItem({
  required docId,
  required DocumentSnapshot document,
  required BuildContext context,
}) {
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
    UserData otherUser =
        data.usersData[0].id != userId ? usersData[0] : usersData[1];
    title = otherUser.name!;
    avatar = CircleAvatar(
      backgroundImage: NetworkImage(otherUser.avatarUrl!),
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
    subtitle: Text(data.lastMessage ?? ""),
    trailing: Text(
      dateToDuration(data.timestamp),
    ),
    onTap: () => {
      navigateToChat(
        context: context,
        docId: docId,
        chatroomName: title,
      ),
    },
  );
}
