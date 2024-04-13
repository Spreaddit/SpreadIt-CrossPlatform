import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = apiUrl;

Future<List<Comment>> getCommentReplies(String commentId) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiroute = '';
    apiroute = "/comments/$commentId/replies";
    String apiUrl = "$baseUrl$apiroute";

    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('${response.data}');
      List<dynamic> commentsJson = response.data['replies'];

      List<Comment> replies =
          commentsJson.map((json) => Comment.fromJson(json)).toList();
      return replies;
    } else {
      throw Exception("Failed to fetch comments: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
