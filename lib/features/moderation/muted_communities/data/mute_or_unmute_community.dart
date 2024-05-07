import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; 
import 'package:spreadit_crossplatform/user_info.dart';

/// Mutes or unmutes a community based on the provided type.
///
/// Sends a POST request to the server to mute or unmute the specified community.
///
/// The [communityName] parameter is the name of the community to mute or unmute.
///
/// The [type] parameter specifies the action to perform, it can be either "mute" or "unmute".
///
/// Returns a Future<int> representing the HTTP status code of the response.
/// - 200: Successfully muted or unmuted the community.
/// - 400: Bad request, invalid type or missing access token.
/// - 401: Unauthorized, access token is invalid or expired.
/// - 402: Forbidden, user does not have permission to perform the action.
/// - 404: Not found, the specified community does not exist.
/// - 500: Internal server error or other unexpected error occurred.
///
/// Throws a [DioException] if the request fails due to Dio related issues.
/// Throws a generic [Exception] if any other error occurs.
///
/// Example usage:
/// ```dart
/// try {
///   int statusCode = await muteOrUnmuteCommunity('communityName', 'mute');
///   if (statusCode == 200) {
///     print('Community muted successfully');
///   } else {
///     print('Failed to mute community, status code: $statusCode');
///   }
/// } catch (e) {
///   print('Error occurred: $e');
/// }
/// ```
Future<int> muteOrUnmuteCommunity(String communityName, String type) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    var data = {
      'communityName': communityName,
    };

    switch (type) {
      case "mute":
        apiroute = "/community/mute";
        break;
      case "unmute":
        apiroute = "/community/unmute";
        break;
      default:
        print("Invalid type");
        return 400;
    }

    String requestURL = '$apiUrl$apiroute';

    final response = await Dio().post(
      requestURL,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        print(response.statusMessage);
        return 200;
      case 400:
        print("Bad Request: ${response.statusMessage}");
        return 400;
      case 401:
        print("Unauthorized: ${response.statusMessage}");
        return 401;
      case 402:
        print("Forbidden: ${response.statusMessage}");
        return 402;
      case 404:
        print("Not Found: ${response.statusMessage}");
        return 404;
      case 500:
        print("Server Error: ${response.statusMessage}");
        return 500;
      default:
        print("Unexpected Status Code: ${response.statusCode}");
        return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          print("Bad Request: ${e.response!.statusMessage}");
          return 400;
        case 401:
          print("Unauthorized: ${e.response!.statusMessage}");
          return 401;
        case 402:
          print("Forbidden: ${e.response!.statusMessage}");
          return 402;
        case 404:
          print("Not Found: ${e.response!.statusMessage}");
          return 404;
        case 500:
          print("Server Error: ${e.response!.statusMessage}");
          return 500;
        default:
          print("Unexpected Status Code: ${e.response!.statusCode}");
          return 404;
      }
    }
    print("Dio error occurred: $e");
    return 500;
  } catch (e) {
    print("Error occurred: $e");
    return 500;
  }
}
