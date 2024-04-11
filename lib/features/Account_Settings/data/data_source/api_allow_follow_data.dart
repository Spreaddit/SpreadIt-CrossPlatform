import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves data from the API endpoint '$apiUrl/mobile/settings/blocking-permissions'.
///
/// Returns a [Map] containing the fetched data, with keys 'blockedAccounts' and 'allowFollow'.
///
/// Returns an empty value for 'blockedAccounts', false for 'allowFollow' if the operation fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getData() async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      '$apiUrl/mobile/settings/blocking-permissions',
      options: Options(
        headers: {
          'token': 'Bearer $accessToken',
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
      return {"blockedAccounts": [], "allowFollow": false};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {"blockedAccounts": [], "allowFollow": false};
  }
}

/// Updates data on the API endpoint '$apiUrl/mobile/settings/blocking-permissions'.
///
/// [blkedList] is a [List] of dynamic type representing blocked accounts.
///
/// [updatedVal] is a [bool] value indicating whether to allow follow or not, user is expected
/// to only update the 'allowFollow' key value.
///
/// Returns the status code of the update operation or 0 in case of no response status code.
///
/// Throws an error if updating data fails.
Future<int> updateData({
  required List<dynamic> blkedList,
  required bool updatedVal,
}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {"blockedAccounts": blkedList, "allowFollow": updatedVal};
    final response = await Dio().put(
      '$apiUrl/mobile/settings/blocking-permissions',
      data: data,
      options: Options(
        headers: {
          'token': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else {
      print("Update failed");
      return response.statusCode ?? 0;
    }
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
