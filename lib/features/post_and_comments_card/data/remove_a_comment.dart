import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

/// Removes a comment as spam.
///
/// This function sends a request to the server to remove a comment as spam.
///
/// [communityName] is the name of the community where the comment belongs.
/// [commentId] is the ID of the comment to be removed as spam.
///
/// Throws a DioException if the request fails.
Future<void> removeCommentAsSpam(
    {required String communityName, required String commentId}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String reason = 'spam';
    var apiRoute =
        "/community/moderation/$communityName/$commentId/remove-comment";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().post(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
      data: {
        "removalReason": reason,
      },
    );

    if (response.statusCode == 200) {
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
    } else if (response.statusCode == 402) {
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
