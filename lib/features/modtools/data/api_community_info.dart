import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves community information from the API endpoint '$communityApiUrlGalal/community/get-info'.
/// Takes the [String] parameter [communityName]
///
/// Returns a [Map] containing community information including 'avatar', 'email', and 'username'.
///
/// Returns a [Map] with default values if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>?>? getModCommunityInfo(String communityName) async {
  //TODO - FIX CORS PROBLEM
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      '$galalModUrl/community/get-info',
      queryParameters: {"communityName": communityName},
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      {
        print(response.statusMessage);
        return response.data;
      }
    } else {
      print(
          'Failed to fetch MOD COMMUNITY data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching MOD COMMUNITY data: $e');
    return null;
  }
}

Future<int> updateModCommunityInfo(
  String communityName, {
  String? name,
  bool? is18plus,
  String? communityType,
  String? description,
}) async {
  //TODO - FIX CORS PROBLEM
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var data = {};
    if (name != null) data["name"] = name;
    if (is18plus != null) data["is18plus"] = is18plus;
    if (communityType != null) data["communityType"] = communityType;
    if (description != null) data["description"] = description;

    var response = await Dio().put(
      '$galalModUrl/community/$communityName/edit-info',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      {
        print(response.statusMessage);
        return response.statusCode ?? 0;
      }
    } else {
      print(
          'Failed to update MOD COMMUNITY data. Status code: ${response.statusCode}');
      return response.statusCode ?? 0;
    }
  } catch (e) {
    print('Error updating MOD COMMUNITY data: $e');
    return 0;
  }
}
