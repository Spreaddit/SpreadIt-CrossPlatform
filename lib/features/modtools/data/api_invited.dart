import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Checks if a user has been invited to moderate a community.
///
/// Sends an HTTP GET request to the API endpoint to check if the specified
/// [username] has been invited to moderate the [communityName].
///
/// Returns a map containing information about the invitation if the user has been invited,
/// otherwise an empty map is returned.
///
/// [communityName]: The name of the community to check the invitation for.
/// [username]: The username of the user to check the invitation for.
Future<Map<String, dynamic>> checkIfInvitedRequest(
    {required String communityName, required String username}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().get(
      '$apiUrl/community/moderation/$communityName/$username/is-invited',
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
