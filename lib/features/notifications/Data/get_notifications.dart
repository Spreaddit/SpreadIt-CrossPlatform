import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Fetches notifications for the current user.
///
/// Sends a GET request to the server to fetch notifications for the current user.
///
/// Returns a Future<List<Notifications>> representing the list of notifications.
/// If successful, the list will contain instances of [Notifications] class.
///
/// Throws an [Exception] if any error occurs during the process.
/// Possible error scenarios include:
/// - Unexpected status code received from the server.
/// - Dio related errors.
///
/// Example usage:
/// ```dart
/// try {
///   List<Notifications> notifications = await fetchNotifications();
///   notifications.forEach((notification) {
///     print('Notification: ${notification.message}');
///   });
/// } catch (e) {
///   print('Error occurred: $e');
/// }
/// ```
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
      List<Notifications> notification =
          (response.data as List).map((x) => Notifications.fromJson(x)).toList();
      return notification;
    } else {
      throw Exception("Unexpected status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
