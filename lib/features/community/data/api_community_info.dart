import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

/// Retrieves community information from the API endpoint '$communityApiUrlGalal/community/get-info'.
/// Takes the [String] parameter [communityName]
///
/// Returns a [Map] containing community information including 'avatar', 'email', and 'username'.
///
/// Returns a [Map] with empty key values if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getCommunityInfo(String communityName) async {
  var defaultResponse = {
    "name": "",
    "category": "",
    "communityType": "Public",
    "description": "",
    "image": "",
    "memberscount": 0,
    "rules": [
      {"title": "", "description": "", "reportReason": ""}
    ],
    "dateCreated": "",
    "communityBanner": ""
  };
  try {
    var response = await Dio().get('$communityApiUrlGalal/community/get-info',
        queryParameters: {"communityName": communityName});
    if (response.statusCode == 200) {
      {
        print(response.statusMessage);
        return response.data;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return defaultResponse;
    }
  } catch (e) {
    print('Error fetching data: $e');
    return defaultResponse;
  }
}
