import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

class GetScheduledPostsService {
  Future<List<Post>> getScheduledPosts({
    required String subspreaditName,
  }) async {
    try {
      String? accessToken = UserSingleton().getAccessToken();

      String requestURL =
          '$apiUrl/community/moderation/$subspreaditName/schedule-posts';

      print("post Category Endpoinnnnnt: $requestURL");
      final response = await Dio().get(
        requestURL,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      print('Response data: ${response.data}');
      if (response.statusCode == 200) {
        List<Post> posts =
            (response.data as List).map((x) => Post.fromJson(x)).toList();
        return (posts);
      } else if (response.statusCode == 409) {
        print("Conflict: ${response.statusMessage}");
      } else if (response.statusCode == 400) {
        print("Bad request: ${response.statusMessage}");
      } else {
        print("Internal Server Error: ${response.statusCode}");
      }
      return [];
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          print("Bad request: ${e.response!.statusMessage}");
        } else if (e.response!.statusCode == 409) {
          print("Conflict: ${e.response!.statusMessage}");
        } else {
          print("Internal Server Error: ${e.response!.statusMessage}");
        }
        return [];
      }
      rethrow;
    } catch (e) {
      //TO DO: show error message to user
      print("Error occurred: $e");
      return [];
    }
  }
}
