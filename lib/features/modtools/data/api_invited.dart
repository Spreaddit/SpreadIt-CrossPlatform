import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<Map<String, dynamic>> checkIfInvitedRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      //TODO USE REAL API URL
      '$galalModUrl2/community/moderation/$communityName/$username/is-invited',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("checkIfInvited Response: ${response.statusMessage}");
      return response.data;
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      print(
          "Error checkIfInvited: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    } else if (response.statusCode == 500) {
      print(
          "Error checkIfInvited: ${response.statusMessage}, code: ${response.statusCode}");
      return {};
    }
    return {};
  } catch (e) {
    print("Error checkIfInvited occurred: $e");
    return {};
  }
}
