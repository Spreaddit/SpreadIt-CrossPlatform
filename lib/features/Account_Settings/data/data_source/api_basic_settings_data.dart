import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

/// Retrieves basic account data from the API endpoint '$apiUrl/mobile/settings/general/account'.
///
/// Returns a [Map] containing basic account information including 'email', 'gender', 'country',
/// and 'connectedAccounts'.
/// 
/// Returns an empty value for the keys if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getBasicData() async {
  try {
    var response = await Dio().get('$apiUrl/mobile/settings/general/account');
    if (response.statusCode == 200) {
      {
        print(response.data);
        print(response.statusMessage);
        return response.data;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {
        "email": "",
        "gender": "",
        "country": "",
        "connectedAccounts": [""]
      };
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {
      "email": "",
      "gender": "",
      "country": "",
      "connectedAccounts": [""]
    };
  }
}

/// Updates basic account data on the API endpoint '$apiUrl/mobile/settings/general/account'.
///
/// [updatedData] is a [Map] containing the updated account information to be sent to the API.
///
/// Returns 1 if the update operation was successful, 0 otherwise.
///
/// Throws an error if updating data fails.
Future<int> updateBasicData({required Map<String, dynamic> updatedData}) async {
  try {
    final response = await Dio()
        .put('$apiUrl/mobile/settings/general/account', data: updatedData);
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
