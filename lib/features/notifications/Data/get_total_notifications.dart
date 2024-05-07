import 'package:spreadit_crossplatform/user_info.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

/// Retrieves the count of unread notifications for the current user.
///
/// Sends a GET request to the server to fetch the count of unread notifications for the current user.
///
/// Returns a Future<int> representing the count of unread notifications.
/// If successful, the count of unread notifications is returned.
///
/// Throws an [Exception] if any error occurs during the process.
/// Possible error scenarios include:
/// - Failed to load count due to unexpected status code received from the server.
/// - Dio related errors.
///
/// Example usage:
/// ```dart
/// try {
///   int unreadCount = await getNotificationUnreadCount();
///   print('Unread notification count: $unreadCount');
/// } catch (e) {
///   print('Error occurred: $e');
/// }
/// ```
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
