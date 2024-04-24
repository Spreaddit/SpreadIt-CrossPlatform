import 'package:flutter/material.dart';

class Moderator {
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
}
