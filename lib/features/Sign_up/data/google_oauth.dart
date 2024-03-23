import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

import '../../user.dart';

String apibase = apiUrl;

Future<int> googleOAuthApi({
  required String googleToken,
}) async {
  try {
    const apiroute = "/google/oauth";
    String apiUrl = apibase + apiroute;
    var data = {
      "googleToken": googleToken,
    };
    final response = await Dio().post(apiUrl, data: data);
    if (response.statusCode == 200) {
      String accessToken = response.data['access_token'];
      print("access token:$accessToken");
      String tokenExpirationDate = response.data['access_token'];
      print("token expiration date:$tokenExpirationDate");
      User user = User.fromJson(response.data['user']);
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
      return 409;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    } else if (response.statusCode == 500) {
      print("Server error: ${response.statusMessage}");
      return 500;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
        return 409;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
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
