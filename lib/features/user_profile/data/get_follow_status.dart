import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import '../../../user_info.dart';

/// Sends a GET request to check if a user is followed and handles response status codes.
Future<bool?> isFollowed(String username) async {
  try {
    String? accessToken = UserSingleton().accessToken; 
    String requestURL = '$apiUrl/users/isfollowed/$username';

    final response = await Dio().get(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      bool followed= response.data['isFollowed'] as bool;
      print('followed$followed');
      return followed;
    } else if (response.statusCode == 404) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      throw Exception('Failed to fetch follow status: ${response.statusCode}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 404) {
        return null;
      } if (e.response!.statusCode == 500) {
        return null;
      }  else {
        throw Exception('Failed to fetch follow status: ${e.response!.statusCode}');
      }
    } else {
      throw Exception('Failed to fetch follow status: Dio error');
    }
  } catch (e) {
    throw Exception('Failed to fetch follow status: $e');
  }
}
