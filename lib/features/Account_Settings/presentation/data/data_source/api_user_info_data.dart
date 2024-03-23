import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getData() async {
  try {
    var response = await Dio().get(
        'http://localhost:3001/M7MDREFAAT550/Spreadit/2.0.0/user-info');
    if (response.statusCode == 200) {
      {
        print(response.data);
        print(response.statusMessage);
        return response.data;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {
        "avatar": "",
        "email": "",
        "username": ""
      };
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {
      "avatar": "",
      "email": "",
      "username": ""
    };
  }
}

Future<int> updateData({required Map<String, dynamic> updatedData}) async {
  try {
    final response = await Dio().put(
        'http://localhost:3001/M7MDREFAAT550/Spreadit/2.0.0/user-info',
        data: updatedData);
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
