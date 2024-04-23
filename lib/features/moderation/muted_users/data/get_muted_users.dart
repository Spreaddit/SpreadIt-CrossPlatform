import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/muted_user_class_model.dart'; 
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = apiUrl; /// Base URL for API requests.

/// Fetches muted users for a community.
///
/// This function sends a GET request to the server to fetch muted users for a community.
///
/// Parameters:
///   - communityName: The name of the community to fetch muted users from.
///
/// Returns:
///   - A Future<List<MutedUser>> representing the list of muted users fetched from the server.

var baseurl=  "http://192.168.1.4:3001/MOHAMEDREFAAT031/Notification/2.0.0";
Future<List<MutedUser>> getMutedUsers(String communityName) async {
  try {
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;

    /// Construct the complete API URL.
    String apiroute = "/community/moderation/$communityName/muted-users";
    String apiUrl = "$baseurl$apiroute";

    /// Send a GET request to the server to fetch muted users.
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
      List<dynamic> json = response.data;
      List<MutedUser> mutedUsers = json.map((json) => MutedUser.fromJson(json)).toList();
      return mutedUsers;
    } else if (response.statusCode == 404) {
      print("Community not found");
      return [];
    } else {
      throw Exception("Failed to fetch muted users: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 404) {
      print("Community not found");
      return [];
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
