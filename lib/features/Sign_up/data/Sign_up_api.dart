import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/sign_up/data/oauth_service.dart';
import '../../../user_info.dart';
import '../../user.dart';

/// Base URL for the API.
String apibase = apiUrl;

/// takes [username] , [password] and [email] as a parameter and
/// returns user info and access token if the user is successfully signed up
Future<int> signUpApi({
  required String username,
  required String email,
  required String password,
}) async {
  try {
    const apiroute = "/signup";
    String apiUrl = apibase + apiroute;
    var data = {"username": username, "email": email, "password": password , "is_cross" :true};
    final response = await Dio().post(apiUrl, data: data);

    if (response.statusCode == 200) {
      await signInwithEmailandPassword(email , password);
      return 200;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
      return 409;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
        return 409;
      }
    }
    print("Dio error occurred: $e");
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
