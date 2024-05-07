import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import '../../../user_info.dart'; // Importing user information.

/// Disables notifications for a specific community.
///
/// Sends a POST request to the server to disable notifications for the specified community.
///
/// The [id] parameter is the identifier of the community for which to disable notifications.
///
/// Returns a Future<int> representing the HTTP status code of the response.
/// - 200: Successfully disabled notifications for the community.
/// - 404: Not found, the specified community does not exist.
/// - 500: Internal server error or other unexpected error occurred.
///
/// Throws a [DioException] if the request fails due to Dio related issues.
/// Throws a generic [Exception] if any other error occurs.
///
/// Example usage:
/// ```dart
/// try {
///   int statusCode = await disableCommunitynotifications(id: 'communityId');
///   if (statusCode == 200) {
///     print('Notifications disabled successfully');
///   } else {
///     print('Failed to disable notifications, status code: $statusCode');
///   }
/// } catch (e) {
///   print('Error occurred: $e');
/// }
/// ```
Future<int> disableCommunitynotifications({
  required String id,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String requestURL = '$apiUrl/community/update/disable/$id';
    
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
    } else if (response.statusCode == 404) {
      print("Not Found: ${response.statusMessage}");
      return 404;
    } else if (response.statusCode == 500) {
      print("Server Error: ${response.statusMessage}");
      return 500;
    } else {
      print("Unexpected Status Code: ${response.statusCode}");
      return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 404) {
        print("Not Found: ${e.response!.statusMessage}");
        return 404;
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
