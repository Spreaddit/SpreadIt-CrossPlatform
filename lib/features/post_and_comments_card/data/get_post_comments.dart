import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = apiUrl;

Future<List<Comment>> fetchCommentsData(
    String? username, String page, String? postId) async {
  try {
    print("fetch");
    String? accessToken = UserSingleton().accessToken;
    String apiroute = '';
    switch (page) {
      case 'saved':
        apiroute = "/comments/saved/$username";
        break;
      case 'user':
        apiroute = "/comments/user/$username";
        break;
      case 'post':
        apiroute = "/posts/comment/$postId";
    }
    String apiUrl = "$baseUrl$apiroute";

    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> commentsJson = response.data['comments'];

      List<Comment> comments =
          commentsJson.map((json) => Comment.fromJson(json)).toList();
      return comments;
    } else {
      throw Exception("Failed to fetch comments: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
