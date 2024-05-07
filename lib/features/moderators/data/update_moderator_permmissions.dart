import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Updates the permissions of a moderator in a community.
///
/// This function sends a PUT request to the server to update the permissions
/// of a moderator in a specific community.
///
/// Parameters:
/// - `communityName`: The name of the community where the moderator's
///   permissions will be updated.
/// - `username`: The username of the moderator whose permissions will be
///   updated.
/// - `managePostsAndComments`: A boolean value indicating whether the moderator
///   should have permission to manage posts and comments in the community.
/// - `manageUsers`: A boolean value indicating whether the moderator should
///   have permission to manage users in the community.
/// - `manageSettings`: A boolean value indicating whether the moderator should
///   have permission to manage settings in the community.
///
/// Throws:
/// - DioError: If an error occurs during the HTTP request.

String apibase = apiUrl;

Future<void> updatePermissions({
  required String communityName,
  required String username,
  required bool managePostsAndComments,
  required bool manageUsers,
  required bool manageSettings,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    var apiRoute = "/community/moderation/$communityName/$username/permissions";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().put(
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
