import 'dart:convert';

import 'package:dio/dio.dart';
import '../../user.dart';

const apibase = "http://localhost:3001/AMIRAELGARF02/Spreadit1/1.0.0";

Future<int> signUpApi({
  required String username,
  required String email,
  required String password,
}) async {
  try {
    const apiroute = "/signup";
    const apiURl = apibase + apiroute;
    var data = {"username": username, "email": email, "password": password};
    final response = await Dio().post(apiURl, data: data);

    if (response.statusCode == 200) {
      String access_token = response.data['access_token'];
      print("access token:$access_token");
      String token_expiration_date = response.data['access_token'];
      User user = User.fromJson(response.data['user']);

      // User user = User.fromJson(jsonDecode(jsonMap));
      print('User ID: ${user.id}');
      return 200;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
      return 409;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
        return 409;
      }
    }
    print("Dio error occurred: $e");
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
