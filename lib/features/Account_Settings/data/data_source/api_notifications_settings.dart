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
Future<List> getData() async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
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
        Map<String, dynamic> data = response.data['notifications'];
        List<bool> notifications =
            data.values.map<bool>((value) => value as bool).toList();

        print(notifications);
        return notifications;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return List.generate(11, (_) => false);
    }
  } catch (e) {
    print('Error fetching data: $e');
    return List.generate(11, (_) => false);
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
Future<int> updateData({required List<dynamic> updatedList}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    Map<String, bool> notificationsMap = {
      "inboxMessages": updatedList[0],
      "chatMessages": updatedList[1],
      "chatRequests": updatedList[2],
      "mentions": updatedList[3],
      "commentsOnYourPost": updatedList[4],
      "commentsYouFollow": updatedList[5],
      "upvotes": updatedList[6],
      "repliesToComments": updatedList[7],
      "newFollowers": updatedList[8],
      "cakeDay": updatedList[9],
      "modNotifications": updatedList[10],
    };
    var data = {"notifications": notificationsMap};
    final response = await Dio().put(
      '$apiUrl/mobile/settings/contact',
      data: data,
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
