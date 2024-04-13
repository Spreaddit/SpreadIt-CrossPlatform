import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves user information from the API endpoint '$apiUrl/user-info'.
///
/// Returns a [Map] containing user information including 'avatar', 'email', and 'username'.
///
/// Returns a [Map] with empty key values if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getUserInfo() async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      '$apiUrl/reset-password/user-info',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      {
        print(response.data);
        print(response.statusMessage);
        return response.data;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {"avatar": "", "email": "", "username": ""};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {"avatar": "", "email": "", "username": ""};
  }
}

/// Updates user information on the API endpoint '$apiUrl/user-info'.
///
/// [updatedData] is a [Map] containing the updated user information to be sent to the API.
///
/// Returns 1 if the update operation was successful, 0 otherwise.
///
/// Throws an error if updating data fails.
Future<int> updateUserInfo({required Map<String, dynamic> updatedData}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().put(
      '$apiUrl/reset-password/user-info',
      data: updatedData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return 1;
    } else {
      print("Update failed");
      return 0;
    }
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
