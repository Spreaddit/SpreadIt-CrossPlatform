import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

Future<List> getData() async {
  try {
    var response = await Dio().get('$apiUrl/mobile/settings/contact');
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

Future<int> updateData({required List<dynamic> updatedList}) async {
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
    final response =
        await Dio().put('$apiUrl/mobile/settings/contact', data: data);
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
