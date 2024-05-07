import 'package:flutter/material.dart';
import 'dart:convert';

/// Represents a moderator in a community.
class Moderator {
  /// The username of the moderator.
  String username;

  /// The banner of the moderator.
  String banner;

  /// The avatar of the moderator.
  String avatar;

  /// The date when the moderator was assigned.
  DateTime moderationDate;

  /// A boolean indicating whether the moderator has permission to manage posts and comments.
  bool managePostsAndComments;

  /// A boolean indicating whether the moderator has permission to manage users.
  bool manageUsers;

  /// A boolean indicating whether the moderator has permission to manage settings.
  bool manageSettings;

  /// The name of the community where the moderator is assigned.
  String communityName;

  /// Constructs a Moderator instance.
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

  /// Converts the Moderator instance to a JSON object.
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

  /// Converts the Moderator instance to a JSON object.
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
