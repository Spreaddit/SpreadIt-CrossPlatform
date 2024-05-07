import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> verifyEmail({required String emailToken}) async {
  String? accessToken = UserSingleton().getAccessToken();
  try {
    final response = await Dio().post(
      '$apiUrl/verify-email/$emailToken',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 404) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      return response.statusCode ?? 0;
    }
    return 0;
  } catch (e) {
    print("Error occurred: $e");
    return 0;
  }
}
