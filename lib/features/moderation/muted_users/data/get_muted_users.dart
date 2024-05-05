import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/muted_user_class_model.dart'; 
import 'package:spreadit_crossplatform/user_info.dart';

/// Retrieves a list of muted users in a community.
///
/// This function sends a request to the server to fetch a list of users who have been muted in a specified community.
///
/// The [communityName] parameter is the name of the community for which to retrieve muted users.
///
/// Returns a Future<List<MutedUser>> representing the list of muted users.
/// If successful, the list will contain instances of [MutedUser] class.
/// If the community is not found or there are no muted users, an empty list is returned.
///
/// Example usage:
/// ```dart
/// List<MutedUser> mutedUsers = await getMutedUsers('communityName');
/// mutedUsers.forEach((user) {
///   print('Muted user: ${user.username}');
/// });
/// ```
Future<List<MutedUser>> getMutedUsers(String communityName) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    String apiroute = "/community/moderation/$communityName/muted-users";
    String route = "$apiUrl$apiroute";

    final response = await Dio().get(
      route,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

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
