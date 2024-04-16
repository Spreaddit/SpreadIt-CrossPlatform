import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Sends a report for a post.
///
/// Returns the status code of the report request.
Future<int> reportPostRequest(String postId,
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    print(postId);
    print(postRequestInfo);
    final response = await Dio().post(
      '$apiUrl/posts/$postId/report',
      data: postRequestInfo,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 201) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 404) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}

/// Sends a report for a comment.
///
/// Returns the status code of the report request.
Future<int> reportCommentRequest(String postId, String commentId,
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    //TODO: CHANGE THE API ENDPOINT WHEN THE SWAGGER HUB IS UPDATED
    //Currently on Swagger:
    /* String currentSwaggerUrl =
        '$interactionsApiUrlGalal/posts/$postId/comments/$commentId/report'; */
    final response = await Dio().post(
      '$apiUrl/comments/$commentId/report',
      data: postRequestInfo,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 201) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 404) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
