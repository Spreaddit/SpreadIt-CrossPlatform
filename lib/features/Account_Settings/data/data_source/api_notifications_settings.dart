import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves contact settings data from the API endpoint '$apiUrl/mobile/settings/contact'.
///
/// Returns a [List] of boolean values representing notifications settings.
///
/// Returns a [List] of false boolean values if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getData() async {
  String? accessToken = UserSingleton().getAccessToken();
  Map<String, dynamic> defaultResponse = {
    "newFollowers": false,
    "mentions": false,
    "inboxMessages": false,
    "chatMessages": false,
    "chatRequests": false,
    "repliesToComments": false,
    "cakeDay": false,
    "modNotifications": false,
    "commentsOnYourPost": false,
    "commentsYouFollow": false,
    "upvotes": false
  };
  try {
    print(accessToken);
    var response = await Dio().get(
      '$apiUrl/mobile/settings/contact',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      {
        print("NOTIFNAOINDOISA: ${response.data}");
        Map<String, dynamic> data = response.data;
        return data;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return defaultResponse;
    }
  } catch (e) {
    print('Error fetching data: $e');
    return defaultResponse;
  }
}

/// Updates contact settings data on the API endpoint '$apiUrl/mobile/settings/contact'.
///
/// [updatedList] is a [List] of boolean values representing updated notification settings
/// in the following order: inboxMessages, chatMessages, chatRequests, mentions,
/// commentsOnYourPost, commentsYouFollow, upvotes, repliesToComments, newFollowers,
/// cakeDay, and modNotifications.
///
/// Returns the status code of the update operation or 0 in case of no response status code.
///
/// Throws an error if updating data fails.
Future<int> updateData({required Map<String, dynamic> updatedNotificationsSettings}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().put(
      '$apiUrl/mobile/settings/contact',
      data: updatedNotificationsSettings,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else {
      print("Update failed");
      return response.statusCode ?? 0;
    }
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
