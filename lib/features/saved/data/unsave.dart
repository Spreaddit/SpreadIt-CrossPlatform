import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';


/// Sends a POST request to unsave a post and handles response status codes.
Future<int> unsavePost({
  required String id,
  required String accessToken,
}) async {
  try {
    var apiroute = "/posts/$id/unsave";
    String requestURL = apiUrl + apiroute;

    var data = {
      "accessToken": accessToken,
    };

    final response = await Dio().post(
      requestURL,
      queryParameters: data,
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
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}