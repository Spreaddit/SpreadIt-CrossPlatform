import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves community information from the API endpoint '$communityApiUrlGalal/community/get-info'.
/// Takes the [String] parameter [communityName]
///
/// Returns a [Map] containing community information.
///
/// Returns a [Map] with default values if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getCommunityInfo(String communityName) async {
  var defaultResponse = {
    "name": "",
    "category": "",
    "is18plus": "false",
    "communityType": "Public",
    "description": "",
    "image": "",
    "membersCount": 0,
    "rules": [],
    "dateCreated": "",
    "communityBanner": ""
  };
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      //TODO: Change the API URL to: '$apiUrl/community/$communityName/get-info'
      '$apiUrl/community/$communityName/get-info',
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
      print("kys");
      print('getCommunityInfo Failed to fetch data. Status code: ${response.statusCode}');
      return defaultResponse;
    }
  } catch (e) {
    print("kyss");
    print('getCommunityInfo Error fetching data: $e');
    return defaultResponse;
  }
}
