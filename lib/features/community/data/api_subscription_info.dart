import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves the subscription status of a community.
///
/// This method takes the [communityName] as a parameter and returns a [Future] that resolves to a [Map] containing the subscription status information.
/// The returned [Map] has a key-value pair where the key is a [String] representing the subscription status and the value is a [dynamic] representing the status details.
///
/// Example usage:
/// ```dart
/// Map<String, dynamic> status = await getCommunitySubStatus('communityName');
/// print(status);
/// ```
Future<Map<String, dynamic>> getCommunitySubStatus(String communityName) async {
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

/// Sends a subscription request to the server and returns the response status code.
///
/// Returns a [Future] that completes with an [int] representing the response status code.
/// The response status code indicates the success or failure of the subscription request.
Future<int> postSubscribeRequest(
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  print(postRequestInfo['name']);
  try {
    final response = await Dio().post(
      '$apiUrl/community/subscribe',
      data: {
        "communityName": postRequestInfo['name'],
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    print(response.statusCode);
    print(response.statusMessage);
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

/// Sends a request to unsubscribe from a certain feature.
///
/// Returns a [Future] that completes with an [int] value representing the result of the request.
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
