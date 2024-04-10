import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

Future<int> reportPostRequest(String postId,
    {required Map<String, dynamic> postRequestInfo}) async {
  try {
    print(postRequestInfo);
    final response = await Dio().post(
        '$interactionsApiUrlGalal/posts/$postId/report',
        data: postRequestInfo);
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
  try {
    //TODO: CHANGE THE API ENDPOINT WHEN THE SWAGGER HUB IS UPDATED
    final response = await Dio().post(
        '$interactionsApiUrlGalal/posts/$postId/comments/$commentId/report',
        data: postRequestInfo);
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