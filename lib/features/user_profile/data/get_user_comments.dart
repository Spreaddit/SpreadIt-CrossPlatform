import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import '../../../user_info.dart';
import './class_models/comments_class_model.dart';

String baseUrl = apiUrl;

Future<List<Comment>> fetchUserComments(String username, String page , String postId) async {
  try {
     String? accessToken = UserSingleton().accessToken; 
    String apiroute = '';
    switch (page) {
      case 'saved':
        apiroute = "/comments/saved/user";
        break;
      case 'user':
        apiroute = "/comments/user/$username";
        break;
        case 'post':
        apiroute = "/posts/comment/$postId";
        break;
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

    if (response.statusCode == 200) {
      List<dynamic> commentsJson = response.data['comments'];
      List<Comment> comments =
          commentsJson.map((json) => Comment.fromJson(json)).toList();
      return comments;
    } else if (response.statusCode==404)
    {
      print("No comments");
      return [];
    } 
    else {
      throw Exception("Failed to fetch comments: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if(e.response!.statusCode==404)
    {
       print("No comments");
       return [];
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
