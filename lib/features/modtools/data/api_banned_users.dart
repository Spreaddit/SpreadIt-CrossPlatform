import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

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
