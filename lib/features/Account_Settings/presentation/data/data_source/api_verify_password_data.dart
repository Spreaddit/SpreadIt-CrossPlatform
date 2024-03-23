import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

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
