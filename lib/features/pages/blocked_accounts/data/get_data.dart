import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/*Future<void> getData(var jasonList) async {
  try {
    var response = await Dio().get(
        'http://10.0.2.2:3001/M7MDREFAAT550/Spreadit/2.0.0/pages/blocked_acconts/data/get_data.dart');
    if (response.statusCode == 200) {
      jasonList = response.data["blockedAccounts"] as List;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}*/
Future<List> getData() async {
  try {
    var response = await Dio().get(
        'http://localhost:3001/AMIRAELGARF02/Spreadit1/1.0.0/mobile/settings/blocking-permissions');
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
