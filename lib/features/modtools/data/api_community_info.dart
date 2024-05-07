import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves the moderation community information for a given community name.
///
/// The [communityName] parameter specifies the name of the community for which the information is to be retrieved.
///
/// Returns a [Future] that resolves to a [Map<String, dynamic>] containing the community information, or `null` if an error occurs.
/// 
/// Throws an exception if there is an error fetching the community information.
Future<Map<String, dynamic>?>? getModCommunityInfo(String communityName) async {
  //TODO - CHECK CORS PROBLEM IN BE INTEGRATION
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      //TODO: Change the API URL to: '$apiUrl/community/$communityName/get-info'
      '$apiUrl/community/$communityName/get-info',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("getModCommunityInfo Response: ${response.statusMessage}");
      return response.data;
    } else {
      print(
          'Failed to fetch getModCommunityInfo data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching getModCommunityInfo data: $e');
    return null;
  }
}

/// Updates the mod community information.
///
/// Returns a [Future] that completes with an [int] representing the status code of the update operation.
/// The status code indicates whether the update was successful or not.
///
/// Example usage:
/// ```dart
/// int statusCode = await updateModCommunityInfo();
/// print('Update status code: $statusCode');
/// ```
///
/// Throws an [Exception] if an error occurs during the update process.
Future<int> updateModCommunityInfo(
  String communityName, {
  String? name,
  bool? is18plus,
  String? communityType,
  String? description,
}) async {
  //TODO - CHECK CORS PROBLEM IN BE INTEGRATION
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {};
    if (name != null) data["name"] = name;
    if (is18plus != null) data["is18plus"] = is18plus;
    if (communityType != null) data["communityType"] = communityType;
    if (description != null) data["description"] = description;

    var response = await Dio().post(
      //TODO: Change the API URL to: '$apiUrl/community/$communityName/edit-info'
      '$apiUrl/community/$communityName/edit-info',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("updateModCommunityInfo Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
    } else {
      print(
          'Failed to updateModCommunityInfo data. Status code: ${response.statusCode}');
      return response.statusCode ?? 0;
    }
  } catch (e) {
    print('Error updateModCommunityInfo data: $e');
    return 0;
  }
}
