import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

import '../../../user_info.dart';

/// Sends a POST request to unsave a post or comment and handles response status codes.
Future<int> saveOrUnsave({
  required String id,
  required String type,
}) async {
  try {
    String apiroute;
    String? accessToken = UserSingleton().accessToken;
    String userId= UserSingleton().user!.id;
    switch (type) {
      case "savepost":
        apiroute = "/posts/$id/save?userId=$userId";
        break;
      case "unsavepost":
        apiroute = "/posts/$id/unsave?userId=$userId";
        break;
      case "comments":
        apiroute = "/comments/$id/save";
        break;
      default:
        print("Invalid type");
        return 400;
    }

    String requestURL = '$apiUrl$apiroute';
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
