import 'package:flutter/material.dart';
import 'dart:convert';

/*class Moderator {
  String username;
  String profilepic;
  DateTime moderatorSince;
  bool isFullPermissions;
  bool isAccess;
  bool isPosts;

  Moderator({
    required this.username,
    required this.profilepic,
    required this.moderatorSince,
    required this.isFullPermissions,
    required this.isPosts,
    required this.isAccess,
  });
}*/

class Moderator {
  String username;
  String banner;
  String avatar;
  DateTime moderationDate;
  bool managePostsAndComments;
  bool manageUsers;
  bool manageSettings;
  String communityName;

  Moderator({
    required this.username,
    required this.banner,
    required this.avatar,
    required this.moderationDate,
    required this.managePostsAndComments,
    required this.manageUsers,
    required this.manageSettings,
    required this.communityName,
  });

  factory Moderator.fromJson(Map<String, dynamic> json) {
    return Moderator(
      username: json['username'],
      banner: json['banner'],
      avatar: json['avatar'],
      moderationDate: DateTime.parse(json['moderationDate']),
      managePostsAndComments: json['managePostsAndComments'],
      manageUsers: json['manageUsers'],
      manageSettings: json['manageSettings'],
      communityName: json['communityName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'banner': banner,
      'avatar': avatar,
      'moderationDate': moderationDate.toIso8601String(),
      'managePostsAndComments': managePostsAndComments,
      'manageUsers': manageUsers,
      'manageSettings': manageSettings,
      'communityName': communityName,
    };
  }
}
