import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

Future<void> updateBlockedAccounts({required List<dynamic> updatedList}) async {
  try {
    var data = {"blockedAccounts": updatedList, "allowFollow": true};
    final response = await Dio()
        .put('$apiUrl/mobile/settings/blocking-permissions', data: data);
    if (response.statusCode == 200) {
      print(response.statusMessage);
    } else {
      print("Update failed");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}
