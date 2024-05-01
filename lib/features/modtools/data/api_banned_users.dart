import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> banUserRequest(
    {required String communityName,
    required String username,
    required String violation,
    required int days,
    required String banReason,
    required String messageToUser}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {
      "violation": violation,
      "days": days,
      "banReason": banReason,
      "messageToUser": messageToUser
    };
    final response = await Dio().post(
      //TODO USE REAL API URL
      '$galalModUrl/community/moderation/$communityName/$username/ban',
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
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

Future<int> unbanUserRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      //TODO USE REAL API URL
      '$galalModUrl/community/moderation/$communityName/$username/unban',
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
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

Future<int> editBannedUserRequest(
    {required String communityName,
    required String username,
    required String violation,
    required int days,
    required String banReason,
    required String messageToUser}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {
      "violation": violation,
      "days": days,
      "banReason": banReason,
      "messageToUser": messageToUser
    };
    final response = await Dio().put(
      //TODO USE REAL API URL
      '$galalModUrl/community/moderation/$communityName/$username/ban',
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
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

Future<List<dynamic>> getBannedUsersRequest(String communityName) async {
  String? accessToken = UserSingleton().getAccessToken();
  List<dynamic> defaultResponse = [];
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$galalModUrl/community/moderation/$communityName/banned-users',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("getBannedUsersRequest Response: ${response.statusMessage}");
      return response.data ?? 0;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    } else if (response.statusCode == 500) {
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return defaultResponse;
    }
    return defaultResponse;
  } catch (e) {
    print("Error occurred: $e");
    return defaultResponse;
  }
}

Future<Map<String, dynamic>> checkIfBannedRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$galalModUrl2/community/moderation/$communityName/$username/is-banned',
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
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    } else if (response.statusCode == 500) {
      print("Error: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    }
    return {};
  } catch (e) {
    print("Error occurred: $e");
    return {};
  }
}
