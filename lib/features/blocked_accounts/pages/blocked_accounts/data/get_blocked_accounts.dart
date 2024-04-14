import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Fetches the list of blocked accounts from the server.
///
/// This function sends a GET request to the server to retrieve the list of blocked accounts.
/// It expects the server to respond with a JSON object containing a key 'blockedAccounts',
/// which holds the list of blocked accounts.
///
/// If the request is successful (HTTP status code 200), it returns the list of blocked accounts.
/// If the request fails or encounters an error, it returns an empty list.
///
/// Throws an exception if there is an error during the network request.
///
/// Example usage:
///
/// ```dart
/// var blockedAccounts = await getBlockedAccounts();
/// ```
///
/// Returns a Future that completes with a list of blocked accounts.

Future<List> getBlockedAccounts() async {
  try {
    print("gowa blocked accounts");
    String? accessToken = UserSingleton().getAccessToken();

    var response = await Dio().get(
      '$apiUrl/mobile/settings/blocking-permissions',
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );
    if (response.statusCode == 200) {
      {
        print("response data${response.data}");
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
