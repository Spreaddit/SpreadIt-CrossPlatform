import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import '../../../user_info.dart'; // Importing user information.


Future<int> disableCommunitynotifications({
  required String id,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String requestURL = '$apiUrl/community/update/disable/$id';
    


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
