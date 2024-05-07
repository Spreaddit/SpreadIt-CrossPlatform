import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import '../../../user_info.dart'; // Importing user information.

/// Hides a notification with the specified ID.
///
/// Sends a POST request to the server to hide the notification with the specified ID.
///
/// The [id] parameter is the identifier of the notification to hide.
///
/// Returns a Future<int> representing the HTTP status code of the response.
/// - 200: Successfully hidden the notification.
/// - 400: Bad request, invalid ID or missing access token.
/// - 500: Internal server error or other unexpected error occurred.
///
/// Throws a [DioException] if the request fails due to Dio related issues.
/// Throws a generic [Exception] if any other error occurs.
///
/// Example usage:
/// ```dart
/// try {
///   int statusCode = await HideNotification(id: 'notificationId');
///   if (statusCode == 200) {
///     print('Notification hidden successfully');
///   } else {
///     print('Failed to hide notification, status code: $statusCode');
///   }
/// } catch (e) {
///   print('Error occurred: $e');
/// }
/// ```
Future<int> hideNotification({
  required String id,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String requestURL = '$apiUrl/notifications/hide/$id';
    
    final response = await Dio().post(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    } else if (response.statusCode == 500) {
      print("Server Error: ${response.statusMessage}");
      return 500;
    } else {
      print("Unexpected Status Code: ${response.statusCode}");
      return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 500) {
        print("Server Error: ${e.response!.statusMessage}");
        return 500;
      }
    }
    print("Dio error occurred: $e");
    return 500;
  } catch (e) {
    print("Error occurred: $e");
    return 500;
  }
}
