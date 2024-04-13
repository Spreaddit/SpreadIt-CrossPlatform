import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import '../../../user_info.dart';

/// Sends a GET request to check if a user is followed and handles response status codes.
///
/// This function sends a GET request to the server to check if a user is followed
/// and handles different response status codes accordingly.
///
/// Parameters:
///   - username: The username of the user to check if followed.
///
/// Returns:
///   - A Future<bool?> representing whether the user is followed:
///     - true if the user is followed.
///     - false if the user is not followed.
///     - null if the follow status cannot be determined or an error occurs.
Future<bool?> isFollowed(String username) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String requestURL = '$apiUrl/users/isfollowed/$username';

    /// Send a GET request to the server to check if the user is followed.
    final response = await Dio().get(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    
    /// Process the response based on the status code.
    if (response.statusCode == 200) {
      bool followed = response.data['isFollowed'] as bool;
      print('followed$followed');
      return followed;
    } else if (response.statusCode == 404 || response.statusCode == 500) {
      return null;
    } else {
      throw Exception('Failed to fetch follow status: ${response.statusCode}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 404 || e.response!.statusCode == 500) {
        return null;
      } else {
        throw Exception('Failed to fetch follow status: ${e.response!.statusCode}');
      }
    } else {
      throw Exception('Failed to fetch follow status: Dio error');
    }
  } catch (e) {
    throw Exception('Failed to fetch follow status: $e');
  }
}
