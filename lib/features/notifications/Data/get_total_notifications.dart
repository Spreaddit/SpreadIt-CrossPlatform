import 'package:spreadit_crossplatform/user_info.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

const apiUrl = "http://localhost:3001/FAROUQDIAA52/Moderators/1.0.0";


Future<int> getNotificationUnreadCount() async {
  try {
    String? accessToken = UserSingleton().accessToken;

    final response = await Dio().get(
      '$apiUrl/notifications/unread/count',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data['unreadCount'] as int ;
    } else {
      throw Exception('failed to load count');
    }
  } catch (e) {
    throw Exception('Failed to load count: $e ');
  }
}
