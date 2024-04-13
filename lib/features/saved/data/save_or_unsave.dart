import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import '../../../user_info.dart'; // Importing user information.

/// Sends a POST request to save or unsave a post or comment and handles response status codes.
///
/// This function sends a POST request to the server to either save or unsave a post or comment,
/// depending on the specified type. It handles different response status codes accordingly.
///
/// Parameters:
///   - id: The ID of the post or comment to save or unsave.
///   - type: The type of operation to perform ('savepost', 'unsavepost', or 'comments').
///
/// Returns:
///   - A Future<int> representing the HTTP status code of the request:
///     - 200 if successful.
///     - 404 if the resource is not found.
///     - 500 if a server error occurs or an unexpected status code is received.
Future<int> saveOrUnsave({
  required String id,
  required String type,
}) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    
    /// Determine the API route based on the specified type.
    switch (type) {
      case "savepost":
        apiroute = "/posts/$id/save";
        break;
      case "unsavepost":
        apiroute = "/posts/$id/unsave";
        break;
      case "comments":
        apiroute = "/comments/$id/save";
        break;
      default:
        print("Invalid type");
        return 400;
    }

    String requestURL = '$apiUrl$apiroute';
    
    /// Send a POST request to the server to save or unsave the post or comment.
    final response = await Dio().post(
      requestURL,
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
