import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

Future<List> getBlockedAccounts() async {
  try {
    print("gowa blocked accounts");
    var response =
        await Dio().get('$apiUrl/mobile/settings/blocking-permissions');
    if (response.statusCode == 200) {
      {
        print(response.data['blockedAccounts'] as List);
        print(response.statusMessage);
        return response.data['blockedAccounts'] as List;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching data: $e');
    return [];
  }
}
