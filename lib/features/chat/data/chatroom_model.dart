import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class Chatroom {
  final String groupName;
  final String lastMessage;
  final DateTime timestamp;
  final List<String> users;
  final List<UserData> usersData;

  Chatroom({
    required this.groupName,
    required this.lastMessage,
    required this.timestamp,
    required this.users,
    required this.usersData,
  });

  factory Chatroom.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    List<String> users = List<String>.from(documentSnapshot['users']);
    Map<String, dynamic> usersDataMap =
        Map<String, dynamic>.from(documentSnapshot['usersData']);

    List<UserData> usersData = users.map((userId) {
      return UserData.fromMap(usersDataMap[userId]);
    }).toList();

    return Chatroom(
      groupName: documentSnapshot['groupname'],
      lastMessage: documentSnapshot['lastMessage'],
      timestamp: (documentSnapshot['timestamp'] as Timestamp).toDate(),
      users: users,
      usersData: usersData,
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      avatarUrl: data['avatarUrl'],
    );
  }
}
