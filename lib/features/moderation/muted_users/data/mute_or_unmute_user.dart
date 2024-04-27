import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> muteOrUnmuteUser(String communityName, String username, String type,
    String note, bool post) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    var data;

    /// Determine the API route based on the specified type.
    switch (type) {
      case "mute":
        apiroute = "/community/moderation/$communityName/$username/mute";
        data = {'muteReason': note, 'muteDuration': 28};
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
    }
    else 
    {
       response = await Dio().put(
        requestURL,
        data: data,
        options: option,
      );
    }

    /// Process the response based on the status code.
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
        return 404;
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
