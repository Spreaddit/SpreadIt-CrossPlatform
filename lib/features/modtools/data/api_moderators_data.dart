import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Makes a request to get the moderators for a given community.
///
/// Returns a Future that resolves to a List<dynamic> containing the moderators' data.
Future<List<dynamic>> getModeratorsRequest(String communityName) async {
  String? accessToken = UserSingleton().getAccessToken();
  List<dynamic> defaultResponse = [];
  try {
    final response = await Dio().get(
      '$apiUrl/community/moderation/$communityName/moderators',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("getModeratorsRequest data: ${response.data}");
      print("getModeratorsRequest Response: ${response.statusMessage}");
      return response.data ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "getModeratorsRequest Error: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    } else if (response.statusCode == 500) {
      print(
          "getModeratorsRequest Error: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    }
    return defaultResponse;
  } catch (e) {
    print("getModeratorsRequest Error occurred: $e");
    return defaultResponse;
  }
}

/// Checks if a moderator request is valid.
///
/// Returns a Future that completes with a Map containing the response data.
/// Checks if a moderator request is valid.
///
/// This function takes no parameters and returns a [Future] that resolves to a [Map] with a [String] key and [dynamic] value.
/// The returned map contains information about the moderator request.
///
/// Example usage:
/// ```dart
/// Future<Map<String, dynamic>> result = checkIfModeratorRequest();
/// result.then((data) {
///   print(data);
/// });
/// ```
Future<Map<String, dynamic>> checkIfModeratorRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/is-moderator',

      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("checkIfModeratorRequest data: ${response.data}");
      print("checkIfModeratorRequest Response: ${response.statusMessage}");
      return response.data;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error checkIfModeratorRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    } else if (response.statusCode == 500) {
      print(
          "Error checkIfModeratorRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    }
    return {};
  } catch (e) {
    print("Error checkIfModeratorRequest occurred: $e");
    return {};
  }
}
