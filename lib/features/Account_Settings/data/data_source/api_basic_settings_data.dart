import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/user.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves basic account data from the API endpoint '$apiUrl/mobile/settings/general/account'.
///
/// Returns a [Map] containing basic account information including 'email', 'gender', 'country',
/// and 'connectedAccounts'.
///
/// Returns an empty value for the keys if fetching fails.
///
/// Throws an error if fetching data fails.
Future<Map<String, dynamic>> getBasicData() async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    var response = await Dio().get(
      '$apiUrl/mobile/settings/general/account',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      {
        print(response.data);
        print(response.statusMessage);
        if (response.data["email"] == null) {
          response.data["email"] = "";
        }
        response.data["country"] = (response.data["country"] == "")
            ? "No location specified"
            : response.data["country"];
        return response.data;
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {
        "email": "",
        "gender": "",
        "country": "",
        "connectedAccounts": [""]
      };
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {
      "email": "",
      "gender": "",
      "country": "",
      "connectedAccounts": [""]
    };
  }
}

/// Updates basic account data on the API endpoint '$apiUrl/mobile/settings/general/account'.
///
/// [updatedData] is a [Map] containing the updated account information to be sent to the API.
///
/// Returns 1 if the update operation was successful, 0 otherwise.
///
/// Throws an error if updating data fails.
Future<int> updateBasicData({required Map<String, dynamic> updatedData}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    print("$updatedData");
    final response = await Dio().put(
      '$apiUrl/mobile/settings/general/account',
      data: updatedData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return 1;
    } else {
      print("Update failed");
      return 0;
    }
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

Future<Map<String, dynamic>> addConnectedAccount() async {
  var defaultResponse = {"user": {}, "message": ""};
  // TODO ASK IF GOOGLE ID OR TOKEN?
  String? accessToken = UserSingleton().getAccessToken();
  String? googleToken = UserSingleton().googleToken;
  User? user = UserSingleton().getUser();
  String? googleId = user?.googleId;
  try {
    var data = {"googleToken": googleToken};
    final response = await Dio().post(
      '$apiUrl/google/connected-accounts',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.data;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      return defaultResponse;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return defaultResponse;
    }
    return defaultResponse;
  } catch (e) {
    print("Error occurred: $e");
    return defaultResponse;
  }
}
