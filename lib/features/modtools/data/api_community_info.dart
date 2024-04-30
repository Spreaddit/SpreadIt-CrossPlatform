import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<Map<String, dynamic>?>? getModCommunityInfo(String communityName) async {
  //TODO - CHECK CORS PROBLEM IN BE INTEGRATION
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
      print("getModCommunityInfo Response: ${response.statusMessage}");
      return response.data;
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
  //TODO - CHECK CORS PROBLEM IN BE INTEGRATION 
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
      print("updateModCommunityInfo Response: ${response.statusMessage}");
      return response.statusCode ?? 0;
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
