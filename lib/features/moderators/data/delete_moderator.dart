import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Deletes a moderator from a specified community.
///
/// The function sends an HTTP DELETE request to the API endpoint to delete
/// the moderator with the given [username] from the specified [communityName].
///
/// [communityName]: The name of the community from which the moderator is to be deleted.
/// [username]: The username of the moderator to be deleted.
Future<void> deleteModerator(String communityName, String username) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    String apiroute =
        "/community/moderation/$communityName/moderators/$username";

    String api = "$apiUrl$apiroute";

    final response = await Dio().delete(
      api,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("${response.statusMessage}");
      return;
    } else if (response.statusCode == 404) {
    } else {
      throw Exception("Error: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if (e.response!.statusCode == 404) {
      print("No moderators");
      return;
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
