import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> muteOrUnmuteCommunity(String communityName, String type) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    var data = {
      'communityName': communityName,
    };
    print("type $type");
    /// Determine the API route based on the specified type.
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

    /// Send a POST request to the server to mute or unmute the community.
    final response = await Dio().post(
      requestURL,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    /// Process the response based on the status code.
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
          return 404; // Assuming 404 for unhandled status codes
      }
    }
    print("Dio error occurred: $e");
    return 500;
  } catch (e) {
    print("Error occurred: $e");
    return 500;
  }
}
