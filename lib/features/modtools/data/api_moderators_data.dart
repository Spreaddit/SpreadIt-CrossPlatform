import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<List<dynamic>> getModeratorsRequest(String communityName) async {
  String? accessToken = UserSingleton().getAccessToken();
  List<dynamic> defaultResponse = [];
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$galalModUrl2/community/moderation/$communityName/moderators',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("getModeratorsRequest Response: ${response.statusMessage}");
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

Future<Map<String, dynamic>> checkIfModeratorRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$galalModUrl2/community/moderation/$communityName/$username/is-moderator',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
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
