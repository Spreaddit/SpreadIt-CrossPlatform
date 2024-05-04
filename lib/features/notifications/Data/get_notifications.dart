import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';


/// Base URL for API requests.

Future<List<Notifications>> fetchNotifications() async {
  try {
    String? accessToken = UserSingleton().accessToken;
    const apiroute = "/notifications";
    String requestURL = "$apiUrl$apiroute";

    final response = await Dio().get(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response);
       List<Notifications> notification =
          (response.data as List).map((x) => Notifications.fromJson(x)).toList();
      return (notification);
    } else {
      throw Exception("Unexpected status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
