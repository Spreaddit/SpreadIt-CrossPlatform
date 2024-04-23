import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import 'package:spreadit_crossplatform/user_info.dart';

var baseurl = "http://localhost:3001/MOHAMEDREFAAT031/Notification/2.0.0";

Future<int> muteOrUnmuteUser(
    String communityName, String username, String type, String note) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    var data;

    /// Determine the API route based on the specified type.
    switch (type) {
      case "mute":
        apiroute = "/community/moderation/$communityName/$username/mute";
        data = {
          'note': note,
        };
        break;
      case "unmute":
        apiroute = "/community/moderation/$communityName/$username/unmute";
        break;
      default:
        print("Invalid type");
        return 400;
    }

    String requestURL = '$baseurl$apiroute';
    /// Send a POST request to the server to save or unsave the post or comment.

    final response = await Dio().post(
      requestURL,
      data: type=='mute' ? data : null,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    /// Process the response based on the status code.
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
