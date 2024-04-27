import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> banUserRequest(
    {required String communityName,
    required String userName,
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
      '$galalModUrl/community/moderation/$communityName/$userName/ban',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
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
    {required String communityName, required String userName}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      '$galalModUrl/community/moderation/$communityName/$userName/unban',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
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
    required String userName,
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
      '$galalModUrl/community/moderation/$communityName/$userName/ban',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
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
  List<Map<String, dynamic>> defaultResponse = [];
  try {
    final response = await Dio().get(
      '$galalModUrl/community/moderation/$communityName/banned-users',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.data?? 0;
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
