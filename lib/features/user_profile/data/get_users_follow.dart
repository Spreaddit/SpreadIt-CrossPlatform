import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/class_models/followers_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Fetches muted users for a community.
///
/// This function sends a GET request to the server to fetch muted users for a community.
///
/// Parameters:
///   - communityName: The name of the community to fetch muted users from.
///
/// Returns:
///   - A Future<List<MutedUser>> representing the list of muted users fetched from the server.

Future<List<FollowUser>> getFollwersusers() async {
  try {
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;

    /// Construct the complete API URL.
    String apiroute = "/users/getfollowers";
    String route = "$apiUrl$apiroute";
    /// Send a GET request to the server to fetch muted users.
    final response = await Dio().get(
      route,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    /// Process the response based on the status code.
    if (response.statusCode == 200) {
      List<dynamic> json = response.data;
      List<FollowUser> followersusers =
          json.map((json) => FollowUser.fromJson(json)).toList();
      return followersusers;
    } else if (response.statusCode == 404) {
      print("User not found or has no followers");
      return [];
    } else if (response.statusCode == 500) {
      print("internal server error");
      return [];
    } else {
      throw Exception("Failed to fetch follower: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 404) {
      print("User not found or has no followers");
      return [];
    } else if (e.response!.statusCode == 500) {
      print("internal server error");
      return [];
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
