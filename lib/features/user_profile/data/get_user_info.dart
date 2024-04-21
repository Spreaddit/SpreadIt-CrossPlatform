import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import './class_models/user_info_class_model.dart';

String baseUrl = apiUrl; /// Base URL for API requests.

/// Fetches user information for the specified username.
///
/// This function sends a GET request to the server to fetch user information
/// for the specified username. It handles different response status codes accordingly.
///
/// Parameters:
///   - username: The username of the user whose information to fetch.
///
/// Returns:
///   - A Future<UserInfo> representing the user information fetched from the server.
Future<UserInfo> fetchUserInfo(String username) async {
  try {
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;
    const apiroute = "/user/profile-info";
    /// Construct the complete API URL.
    String apiUrl = "$baseUrl$apiroute/$username";

    /// Send a GET request to the server to fetch user information.
    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    /// Process the response based on the status code.
    if (response.statusCode == 200) {
      print(response);
      return UserInfo.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw Exception("Error token is required: ${response.statusMessage}");
    } else if (response.statusCode == 404) {
      throw Exception("User not found: ${response.statusMessage}");
    } else if (response.statusCode == 500) {
      throw Exception("Server error: ${response.statusMessage}");
    } else {
      throw Exception("Unexpected status code: ${response.statusCode}");
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        throw Exception("Error token is required: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 404) {
        throw Exception("User not found: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 500) {
        throw Exception("Server error: ${e.response!.statusMessage}");
      }
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
