import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> approveUserRequest({
  required String communityName,
  required String username,
}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/add-contributor',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("approveUserRequest Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error approveUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(
          "Error approveUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred approveUserRequest: $e");
    return 0;
  }
}

Future<int> removeApprovedUserRequest({
  required String communityName,
  required String username,
}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().delete(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/remove-contributor',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("removeApprovedUserRequest Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error removeApprovedUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(
          "Error removeApprovedUserRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred removeApprovedUserRequest: $e");
    return 0;
  }
}

Future<List<dynamic>> getApprovedUsersRequest(String communityName) async {
  String? accessToken = UserSingleton().getAccessToken();
  List<dynamic> defaultResponse = [];
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/contributors',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("getApprovedUsersRequest data: ${response.data}");
      print("getApprovedUsersRequest Response: ${response.statusMessage}");
      return response.data ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error getApprovedUsersRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    } else if (response.statusCode == 500) {
      print(
          "Error getApprovedUsersRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    }
    return defaultResponse;
  } catch (e) {
    print("Error occurred getApprovedUsersRequest: $e");
    return defaultResponse;
  }
}

Future<Map<String, dynamic>> checkIfApprovedRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$apiUrl/community/moderation/$communityName/$username/is-contributor',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(
          "checkIfApprovedRequest Response: ${response.statusMessage} ${response.data}");
      return response.data;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print("checkIfApprovedRequest: ${response.data}");
      print(
          "Error checkIfApprovedRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return {"isContributor": false};
    } else if (response.statusCode == 500) {
      print(
          "Error checkIfApprovedRequest: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    }
    return {};
  } catch (e) {
    print("Error checkIfApprovedRequest occurred: $e");
    return {"isContributor": false};
  }
}
