import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/class_models/followers_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves a list of followers users from the server.
///
/// This function sends a GET request to the server to fetch a list of users who are followers.
///
/// Returns a list of [FollowUser] instances representing the followers users.
///
/// Throws an exception if an error occurs during the process.
///
/// Example usage:
/// ```dart
/// List<FollowUser> followers = await getFollowersUsers();
/// ```
Future<List<FollowUser>> getFollowersUsers() async {
  try {
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;

    // Construct the complete API URL.
    String apiRoute = "/users/getfollowers";
    String route = "$apiUrl$apiRoute";

    // Send a GET request to the server to fetch followers users.
    final response = await Dio().get(
      route,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    // Process the response based on the status code.
    if (response.statusCode == 200) {
      List<dynamic> json = response.data;
      List<FollowUser> followersUsers =
          json.map((json) => FollowUser.fromJson(json)).toList();
      return followersUsers;
    } else if (response.statusCode == 404) {
      print("User not found or has no followers");
      return [];
    } else if (response.statusCode == 500) {
      print("Internal server error");
      return [];
    } else {
      throw Exception(
          "Failed to fetch followers users: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 404) {
      print("User not found or has no followers");
      return [];
    } else if (e.response != null && e.response!.statusCode == 500) {
      print("Internal server error");
      return [];
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
