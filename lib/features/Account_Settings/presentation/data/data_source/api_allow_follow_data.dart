import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getData() async {
  try {
    var response = await Dio().get(
        'http://localhost:3001/M7MDREFAAT550/Spreadit/2.0.0/mobile/settings/blocking-permissions');
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

Future<int> updateData({required List<dynamic> blkedList, required bool updatedVal}) async {
  try {
    var data = {"blockedAccounts": blkedList, "allowFollow": updatedVal};
    final response = await Dio().put(
        'http://localhost:3001/M7MDREFAAT550/Spreadit/2.0.0/mobile/settings/blocking-permissions',
        data: data);
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