import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import '../../../user_info.dart'; // Importing user information.
import './class_models/comments_class_model.dart'; // Importing the Comment class model.

String baseUrl = apiUrl; // Base URL for API requests.

/// Fetches comments based on the specified page and user information.
///
/// This function sends a GET request to the server to fetch comments based on the specified page and user information,
/// such as the username, page type, and post ID. It handles different response status codes accordingly.
///
/// Parameters:
///   - username: The username of the user whose comments to fetch (used for 'user' page).
///   - page: The type of page to fetch comments from ('saved', 'user', or 'post').
///   - postId: The ID of the post whose comments to fetch (used for 'post' page).
///
/// Returns:
///   - A Future<List<Comment>> representing the list of comments fetched from the server.
Future<List<Comment>> fetchUserComments(String username, String page, String postId) async {
  try {
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;
    String apiroute = '';

    /// Determine the API route based on the specified page.
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

    /// Construct the complete API URL.
    String apiUrl = "$baseUrl$apiroute";

    /// Send a GET request to the server to fetch comments.
    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    /// Process the response based on the status code.
    if (response.statusCode == 200) {
      List<dynamic> commentsJson = response.data['comments'];
      List<Comment> comments = commentsJson.map((json) => Comment.fromJson(json)).toList();
      return comments;
    } else if (response.statusCode == 404) {
      print("No comments");
      return [];
    } else {
      throw Exception("Failed to fetch comments: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if (e.response!.statusCode == 404) {
      print("No comments");
      return [];
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
