import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import '../../../user_info.dart';
import './class_models/comments_class_model.dart';

String baseUrl = apiUrl;

Future<List<Comment>> fetchUserComments(String username, String page) async {
  try {
     String? accessToken = UserSingleton().accessToken; 
    String apiroute = '';
    switch (page) {
      case 'saved':
        apiroute = "/comments/saved";
        break;
      case 'user':
        apiroute = "/comments/user";
        break;
    }
    String apiUrl = "$baseUrl$apiroute/$username";

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
    } else {
      throw Exception("Failed to fetch comments: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
