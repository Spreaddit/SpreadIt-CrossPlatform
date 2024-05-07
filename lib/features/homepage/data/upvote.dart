import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

/// Upvotes a specific post.
///
/// This function sends a request to the server to upvote the specified post.
///
/// [postId] is the ID of the post to upvote.
///
/// Returns the updated number of votes on success, or null if the operation fails.
Future<int?> upvote({required String postId}) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    var apiRoute = "/posts/$postId/upvote";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().post(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.statusMessage);
      Map<String, dynamic> responseData = response.data;
      int votes = responseData['votes'];
      print("succ");
      print("$votes");
      return votes;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else if (response.statusCode == 402) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return null;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return null;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return null;
  }
}
