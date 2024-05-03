import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';


Future<Notifications> getRecommendedCommunity() async {
  try {
    String? accessToken = UserSingleton().accessToken;

    final response = await Dio().get(
      '$apiUrl/community/suggest',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(
        "reponse ${response.data}",
      );
      Notifications community = Notifications.fromJson(response.data);
      print(community);
      return community;
    } else if (response.statusCode == 404) {
      throw Exception("There aren't any recommended community");
    } else if (response.statusCode == 500) {
      throw Exception('Internal server error');
    } else {
      throw Exception('Bad request, invalid request paramters');
    }
  } catch (e) {
    throw Exception('Failed to load communities: $e ');
  }
}
