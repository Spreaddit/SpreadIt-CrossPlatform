
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Base URL for the API.
String apibase = apiUrl;

/// Function to update the content of a post.
///
/// Parameters:
/// - [postId]: The ID of the post to be updated.
/// - [content]: The updated content of the post.
/// - [media]: Media attachments associated with the post.
///
/// Throws a DioException if an error occurs during the Dio request.
Future<void> updateEditedPost({
  required String postId,
  required String? content,
  Media? media,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    
    var apiRoute = "/posts/$postId/edit";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().put(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
      data: {
        "content": content,
        "attachments": media,
      },
    );

    if (response.statusCode == 201) {
      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);

      return;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return;
  }
}