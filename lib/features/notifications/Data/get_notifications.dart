import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = "http://192.168.1.4:3001/MOHAMEDREFAAT031/Notification/2.0.0";

/// Base URL for API requests.

Future<List<Notifications>> fetchNotifications() async {
  try {
    String? accessToken = UserSingleton().accessToken;
    const apiroute = "/notifications";
    String apiUrl = "$baseUrl$apiroute";

    final response = await Dio().get(
      apiUrl,
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
