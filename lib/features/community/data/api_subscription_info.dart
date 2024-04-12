import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<Map<String, dynamic>> getCommunitySubStatus(
    String communityName) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      '$apiUrl/community/is-subscribed',
      queryParameters: {
        "communityName": communityName,
      },
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
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {"isSubscribed": -1};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {"isSubscribed": -1};
  }
}

Future<int> postSubscribeRequest(
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      '$apiUrl/community/subscribe',
      data: postRequestInfo,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 403) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

Future<int> postUnsubscribeRequest(
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      '$apiUrl/community/unsubscribe',
      data: postRequestInfo,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 403) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
