import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> requestAddPasswordEmail() async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {"is_cross": true};
    final response = await Dio().post(
      '$apiUrl/settings/add-password/email',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("Email sent: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 404) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

Future<int> addPasswordRequest({required String password}) async {
  // TODO ASK IF THIS AUTOMATICALLY UPDATES USER EMAIL
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {"password": password};
    final response = await Dio().post(
      '$apiUrl/settings/add-password',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 404) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
