import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Verifies an email using the provided email token.
///
/// Makes a request to the server to verify the email associated with the provided token.
///
/// [emailToken] is the token sent to the user's email for verification.
///
/// Returns a [Future] that resolves to an integer representing the HTTP status code:
/// - 200 if the email verification is successful.
/// - 404 if the user is not found or unauthorized.
/// - 500 if there is an internal server error or any other error occurs.
/// 
Future<int> verifyEmail({
  required String emailToken,
}) async {
  try {
    final String endpoint = '/verify-email/$emailToken';
    final String requestURL = apiUrl + endpoint;

    final Response response = await Dio().post(
      requestURL,
    );
    print('inside verify email');
    if (response.statusCode == 200) {
      UserSingleton().setAccessToken(response.data['accessToken'],
          DateTime.now());
          print('verify successful');
          UserSingleton().setVerifed();
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
