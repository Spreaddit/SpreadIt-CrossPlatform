import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; 
import '../../../user_info.dart'; 

/// Marks notifications as read based on the provided type.
///
/// Sends a PUT request to the server to mark notifications as read based on the specified type.
/// The type can be either "all" to mark all notifications as read or "one" to mark a specific notification as read.
///
/// The [id] parameter is required when the type is "one" and represents the identifier of the notification to mark as read.
///
/// Returns a Future<int> representing the HTTP status code of the response.
/// - 200: Successfully marked notifications as read.
/// - 400: Bad request, invalid type or missing access token.
/// - 404: Not found, the specified notification or endpoint does not exist.
/// - 500: Internal server error or other unexpected error occurred.
///
/// Throws a [DioException] if the request fails due to Dio related issues.
/// Throws a generic [Exception] if any other error occurs.
///
/// Example usage:
/// ```dart
/// try {
///   int statusCode = await MarkAsRead(type: 'all');
///   if (statusCode == 200) {
///     print('Notifications marked as read successfully');
///   } else {
///     print('Failed to mark notifications as read, status code: $statusCode');
///   }
/// } catch (e) {
///   print('Error occurred: $e');
/// }
/// ```
Future<int> markAsRead({
   String? id,
  required String type,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiroute;
     switch (type) {
      case "all":
        apiroute = "notifications/mark-all-as-read";
        break;
      case "one":
        apiroute = "notifications/read-notification/$id";
        break;
      default:
        print("Invalid type");
        return 400;
    }
    var requestURL= "$apiUrl/$apiroute";
    final response = await Dio().put(
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
