import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

Future<int> hidePost(String postId, bool shouldHide) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    var requestUrl = shouldHide
        ? '$apiUrl/posts/$postId/hide'
        : '$apiUrl/posts/$postId/unhide';
    var response = await Dio().post(requestUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));
    if (response.statusCode == 200) {
      print(response.statusMessage);
      print(response.statusCode);
      return 200;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return 500;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 500) {
        print(e.response!.statusMessage);
      }
      return 500;
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
