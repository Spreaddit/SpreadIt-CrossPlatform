import 'dart:io';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'comment_model_class.dart';

String apibase = apiUrl;

Future<Comment?> updateComments({
  required String id,
  required String content,
  Media? media,
  required String type,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = "";

    switch (type) {
      case 'comment':
        apiRoute = "/post/comment/$id"; //id is the postId in this case
        break;
      case 'reply':
        apiRoute =
            "/comment/$id/reply"; //id is the parent comment Id in this case
    }
    String apiUrl = apibase + apiRoute;
    final response = await Dio().post(apiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
        data: {
          "content": content,
          "attachments": media,
        });
    if (response.statusCode == 201) {
      Comment recievedComment = Comment.fromJson(response.data['comment']);
      print('posted comment $recievedComment');

      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);
      return recievedComment;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else if (response.statusCode == 401) {
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
