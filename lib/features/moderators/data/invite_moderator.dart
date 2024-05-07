import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

/// Sends an invitation to a user to become a moderator of a community.
///
/// The function sends an HTTP POST request to the API endpoint to invite a user to become a moderator
/// of a specified community with the provided permissions.
///
/// [communityName]: The name of the community where the user is invited to become a moderator.
/// [username]: The username of the user to be invited as a moderator.
/// [managePostsAndComments]: A boolean indicating whether the invited user will have permission to manage posts and comments.
/// [manageUsers]: A boolean indicating whether the invited user will have permission to manage users.
/// [manageSettings]: A boolean indicating whether the invited user will have permission to manage settings.
Future<void> inviteModerator({
  required String communityName,
  required String username,
  required bool managePostsAndComments,
  required bool manageUsers,
  required bool manageSettings,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    var apiRoute = "/community/moderation/$communityName/$username/invite";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().post(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
      data: {
        "managePostsAndComments": managePostsAndComments,
        "manageUsers": manageUsers,
        "manageSettings": manageSettings,
      },
    );

    if (response.statusCode == 200) {
      print("$managePostsAndComments,$manageUsers,$manageSettings");
      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);

      return;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return;
  }
}
