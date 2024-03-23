import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future<void> updateData({required List<dynamic> updatedList}) async {
  try {
    var data = {"blockedAccounts": updatedList, "allowFollow": true};
    final response = await Dio().put(
        'http://localhost:3001/AMIRAELGARF02/Spreadit1/1.0.0/mobile/settings/blocking-permissions',
        data: data);
    if (response.statusCode == 200) {
      print(response.statusMessage);
    } else {
      print("Update failed");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}
