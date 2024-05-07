import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import 'package:spreadit_crossplatform/user_info.dart';

/// Mutes or unmutes a user in a community.
///
/// This function sends a request to the server to mute or unmute a user in a specified community.
///
/// The [communityName] parameter is the name of the community where the user is to be muted or unmuted.
/// The [username] parameter is the username of the user to be muted or unmuted.
/// The [type] parameter specifies the action to perform, either "mute" or "unmute".
/// The [note] parameter is an optional note to accompany the mute action.
/// The [post] parameter indicates whether to use POST or PUT method for the request.
///
/// Returns a Future<int> representing the status code of the response:
/// - 200 if successful.
/// - 400 for invalid data or parameters.
/// - 401 if unauthorized.
/// - 402 if the user is not a moderator.
/// - 404 if the community or user is not found.
/// - 406 if the moderator doesn't have permission.
/// - 500 for internal server error or other unexpected errors.
///
/// Example usage:
/// ```dart
/// int statusCode = await muteOrUnmuteUser('communityName', 'username', 'mute', 'Reason for mute', true);
/// if (statusCode == 200) {
///   print('User muted successfully');
/// } else {
///   print('Error occurred: $statusCode');
/// }
/// ```
Future<int> muteOrUnmuteUser(String communityName, String username, String type,
    String note, bool post) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    var data;

    switch (type) {
      case "mute":
        apiroute = "/community/moderation/$communityName/$username/mute";
        data = {'muteReason': note, 'muteDuration': 3};
        break;
      case "unmute":
        apiroute = "/community/moderation/$communityName/$username/unmute";
        break;
      default:
        print("Invalid type");
        return 400;
    }

    String requestURL = '$apiUrl$apiroute';
    var option = Options(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    Response response;

    if (post) {
      response = await Dio().post(
        requestURL,
        data: type == 'mute' ? data : null,
        options: option,
      );
    } else {
      response = await Dio().put(
        requestURL,
        data: data,
        options: option,
      );
    }

    switch (response.statusCode) {
      case 200:
        print("User muted successfully");
        return 200;
      case 400:
        print("Invalid data: ${response.statusMessage}");
        return 400;
      case 401:
        print("Unauthorized: ${response.statusMessage}");
        return 401;
      case 402:
        print("Not a moderator: ${response.statusMessage}");
        return 402;
      case 404:
        print("Community or User not found: ${response.statusMessage}");
        return 404;
      case 406:
        print("Moderator doesn't have permission ${response.statusMessage}");
        return 406;
      case 500:
        print("Internal server error: ${response.statusMessage}");
        return 500;
      default:
        print("Unexpected Status Code: ${response.statusCode}");
        return 1;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          print("Invalid data: ${e.response!.statusMessage}");
          return 400;
        case 401:
          print("Unauthorized: ${e.response!.statusMessage}");
          return 401;
        case 402:
          print("Not a moderator: ${e.response!.statusMessage}");
          return 402;
        case 404:
          print("Community or User not found: ${e.response!.statusMessage}");
          return 404;
        case 406:
          print(
              "Moderator doesn't have permission ${e.response!.statusMessage}");
          return 406;
        case 500:
          print("Internal server error: ${e.response!.statusMessage}");
          return 500;
        default:
          print("Unexpected Status Code: ${e.response!.statusCode}");
          return 1; 
      }
    }
    print("Dio error occurred: $e");
    return 500;
  } catch (e) {
    print("Error occurred: $e");
    return 500;
  }
}
