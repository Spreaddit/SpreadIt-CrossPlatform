import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import '../../../user_info.dart';

Future<int> toggleFollow({
  required String username,
  required bool isFollowing,
}) async {
  try {
    String? accessToken=UserSingleton().accessToken;
    final String endpoint = isFollowing ? '/users/unfollow/$accessToken' : '/users/follow/$accessToken';
    final String requestURL = apiUrl + endpoint;

     var data = {
      'username': username,
    };

    final Response response = await Dio().post(
      requestURL,
      data: data,
    );

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
