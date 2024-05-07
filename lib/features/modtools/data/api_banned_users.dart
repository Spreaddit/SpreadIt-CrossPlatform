import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Sends a request to ban a user from a community.
///
/// The [communityName] parameter specifies the name of the community.
/// The [username] parameter specifies the username of the user to be banned.
/// The [violation] parameter specifies the reason for the ban.
/// The [days] parameter specifies the duration of the ban in days.
/// The [messageToUser] parameter specifies the message to be displayed to the banned user.
/// The [modNote] parameter specifies an optional note for the moderator.
///
/// Returns a [Future] that completes with an [int] representing the status code of the request.
/// A status code of 200 indicates a successful ban request.
/// A status code between 400 and 499 indicates a client-side error.
/// A status code of 500 indicates a server-side error.
/// Returns 0 if an error occurs during the request.
Future<int> banUserRequest(
    {required String communityName,
    required String username,
    required String violation,
    required int days,
    required String messageToUser,
    required String modNote}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {
      "reason": violation,
      "isPermanent": days < 0 ? true : false,
      "banDuration": DateTime.now().add(Duration(days: days >= 0 ? days : 1)).toUtc().toIso8601String(),
      "banMessage": messageToUser,
      "modNote": modNote == "" ? null : modNote,
    };
    final response = await Dio().post(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/ban',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("banUserRequest Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error banUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(
          "Error banUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred banUserRequest: $e");
    return 0;
  }
}

/// Sends a request to unban a user in a community.
///
/// The [communityName] parameter specifies the name of the community where the user is banned.
/// The [username] parameter specifies the username of the user to be unbanned.
///
/// Returns a [Future] that completes with an [int] representing the status code of the request.
/// If the request is successful, the status code will be 200.
/// If there is an error, the status code will be 400 for client errors or 500 for server errors.
/// If an exception occurs during the request, the status code will be 0.
///
/// Example usage:
/// ```dart
/// int statusCode = await unbanUserRequest(communityName: 'community', username: 'user123');
/// print('Unban user request status code: $statusCode');
/// ```
Future<int> unbanUserRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/unban',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("unbanUserRequest Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error unbanUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(
          "Error unbanUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred unbanUserRequest: $e");
    return 0;
  }
}
/// Edits the banned user request.
///
/// This method sends a PATCH request to the server to edit the ban details of a user in a community.
///
/// The [communityName] parameter specifies the name of the community.
/// The [username] parameter specifies the username of the user to be banned.
/// The [violation] parameter specifies the reason for the ban.
/// The [days] parameter specifies the duration of the ban in days. Use a negative value for a permanent ban.
/// The [messageToUser] parameter specifies the message to be shown to the banned user.
///
/// Returns a [Future] that completes with an [int] representing the status code of the request.
/// If the request is successful, the status code will be 200.
/// If there is an error, the status code will be non-zero.
/// If an exception occurs, the status code will be 0.
///
/// Example usage:
/// ```dart
/// int statusCode = await editBannedUserRequest(
///   communityName: 'example_community',
///   username: 'example_user',
///   violation: 'spamming',
///   days: 7,
///   messageToUser: 'You have been banned for spamming.',
/// );
/// ```
Future<int> editBannedUserRequest({
  required String communityName,
  required String username,
  required String violation,
  required int days,
  required String messageToUser,
}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {
      "reason": violation,
      "isPermanent": days < 0 ? true : false,
      "banDuration": DateTime.now().add(Duration(days: days >= 0 ? days : 1)).toUtc().toIso8601String(),
      "banMessage": messageToUser,
    };
    final response = await Dio().patch(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/ban',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("editBannedUserRequest Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error editBannedUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(
          "Error editBannedUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred editBannedUserRequest: $e");
    return 0;
  }
}

/// Retrieves a list of banned users for a given community.
///
/// The [communityName] parameter specifies the name of the community.
/// Returns a [Future] that resolves to a [List<dynamic>] containing the banned users.
/// If an error occurs during the API request, an empty list is returned.
Future<List<dynamic>> getBannedUsersRequest(String communityName) async {
  String? accessToken = UserSingleton().getAccessToken();
  List<dynamic> defaultResponse = [];
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/banned-users',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("getBannedUsersRequest data: ${response.data}");
      print("getBannedUsersRequest Response: ${response.statusMessage}");
      return response.data ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error getBannedUsersRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    } else if (response.statusCode == 500) {
      print(
          "Error getBannedUsersRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    }
    return defaultResponse;
  } catch (e) {
    print("Error occurred getBannedUsersRequest: $e");
    return defaultResponse;
  }
}

/// Makes a request to check if a user is banned in a specific community.
///
/// Returns a [Future] that resolves to a [Map] containing the response data.
/// The [communityName] parameter specifies the name of the community to check in.
/// The [username] parameter specifies the username of the user to check.
Future<Map<String, dynamic>> checkIfBannedRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/is-banned',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(
          "checkIfBannedRequest Response: ${response.statusMessage} ${response.data}");
      return response.data;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error checkIfBannedRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    } else if (response.statusCode == 500) {
      print(
          "Error checkIfBannedRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    }
    return {};
  } catch (e) {
    print("Error occurred checkIfBannedRequest: $e");
    return {};
  }
}
