import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

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
