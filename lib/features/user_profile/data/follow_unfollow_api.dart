import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart'; 
import '../../../user_info.dart';

/// Toggles the follow status of a user.
///
/// This function toggles the follow status of a user by sending a request to the
/// server with the user's username and the current follow status.
///
/// Parameters:
///   - username: The username of the user to follow/unfollow.
///   - isFollowing: A boolean indicating whether the user is currently being followed.
///
/// Returns:
///   - A Future<int> representing the HTTP status code of the request:
///     - 200 if successful user folloed/unfollowed.
///     - 404 if the username is required or the user is not found.
///     - 500 if an internal server error occurs.
Future<int> toggleFollow({
  required String username,
  required bool isFollowing,
}) async {
  try {
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;
    /// Determine the endpoint based on the follow status.
    final String endpoint = isFollowing ? '/users/unfollow' : '/users/follow';
    /// Construct the complete request URL.
    final String requestURL = apiUrl + endpoint;

    /// Making the json file that will be passed to the backend
    var data = {
      'username': username,
    };

    /// Send a POST request to the server to toggle the follow status.
    final Response response = await Dio().post(
      requestURL,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    /// Process the response based on the status code.
    if (response.statusCode == 200) {
      if (isFollowing) {
        print('Successfully unfollowed user: $username');
      } else {
        print('Successfully followed user: $username');
      }
      return 200;
    } else if (response.statusCode == 400) {
      print('Username is required ${response.statusCode}');
      return 404;
    } else if (response.statusCode == 404) {
      print('User not found: $username');
      return 404;
    } else {
      print('Internal server error ${response.statusCode}');
      return 500;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      print('Dio error occurred: ${e.response!.data}');
      return e.response!.statusCode!;
    } else {
      print('Dio error occurred: $e');
      return 500;
    }
  } catch (e) {
    print('Error occurred: $e');
    return 500;
  }
}
