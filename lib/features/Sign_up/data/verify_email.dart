import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> verifyEmail({
  required String emailToken,
}) async {
  try {
    final String endpoint = '/verify-email/$emailToken';
    final String requestURL = apiUrl + endpoint;

    final Response response = await Dio().post(
      requestURL,
    );

    if (response.statusCode == 200) {
      UserSingleton().setAccessToken(response.data['accessToken'],
          DateTime.parse(response.data['token_expiration_date']));
      return 200;
    } else if (response.statusCode == 401) {
      print('Unautharized');
      return 404;
    } else if (response.statusCode == 404) {
      print('UsernotFound');
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
