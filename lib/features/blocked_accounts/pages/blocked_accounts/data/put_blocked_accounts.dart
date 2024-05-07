import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Updates the list of blocked accounts on the server.
///
/// This function sends a PUT request to the server to update the list of blocked accounts.
/// It expects the updated list of blocked accounts as input in the form of a List<dynamic>.
///
/// The [updatedList] parameter is required and represents the updated list of blocked accounts.
///
/// The function constructs a JSON object containing the updated list of blocked accounts
/// along with an additional flag 'allowFollow', which is set to true.
///
/// If the request is successful (HTTP status code 200), it prints the status message.
/// If the request fails, it prints "Update failed".
///
/// If an error occurs during the network request, the error message is printed.
///
/// Example usage:
///
/// ```dart
/// await updateBlockedAccounts(updatedList: updatedList);
/// ```
///
/// Throws an exception if there is an error during the network request.
///
/// The [updatedList] parameter must not be null.

Future<void> updateBlockedAccounts({required List<dynamic> updatedList}) async {
  try {
    var data = {"blockedUsers": updatedList, "allowFollow": true};
    String? accessToken = UserSingleton().getAccessToken();
    final response = await Dio().put(
      '$apiUrl/mobile/settings/blocking-permissions',
      data: data,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
    } else {
      print("Update failed");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}
