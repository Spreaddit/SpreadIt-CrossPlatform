import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

/// Posts entered password data to the API endpoint '$apiUrl/settings/layout'.
///
/// [enteredPassowrd] is a [Map] containing the entered password information to be sent to the API.
///
/// Returns the status code of the POST request.
///
/// If the status code is 200, it indicates success.
///
/// If the status code is 401, it indicates that the password is incorrect.
///
/// If the status code is 500, it indicates a server error.
///
/// Returns 0 if an unknown error occurs.
Future<int> postData({required Map<String, dynamic> enteredPassowrd}) async {
  try {
    final response =
        await Dio().post('$apiUrl/settings/layout', data: enteredPassowrd);
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 401) {
      print("Password is incorrect");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print("Server Error");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
