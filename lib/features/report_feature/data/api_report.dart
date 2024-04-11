import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> reportPostRequest(String postId,
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      '$interactionsApiUrlGalal/posts/$postId/report',
      data: postRequestInfo,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
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

Future<int> reportCommentRequest(String postId, String commentId,
    {required Map<String, dynamic> postRequestInfo}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    //TODO: CHANGE THE API ENDPOINT WHEN THE SWAGGER HUB IS UPDATED
    //Currently on Swagger:
    /* String currentSwaggerUrl =
        '$interactionsApiUrlGalal/posts/$postId/comments/$commentId/report'; */
    final response = await Dio().post(
      '$interactionsApiUrlGalal/comments/$commentId/report',
      data: postRequestInfo,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
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
