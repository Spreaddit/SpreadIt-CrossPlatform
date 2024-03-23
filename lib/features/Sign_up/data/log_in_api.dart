import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import '../../user.dart';

String apibase = apiUrl;

Future<int> logInApi({
  required String username,
  required String password,
}) async {
  try {
    const apiroute = "/login";
    String apiUrl = apibase + apiroute;
    var data = {"username": username, "password": password};
    final response = await Dio().post(apiUrl, data: data);

    if (response.statusCode == 200) {
      String accessToken = response.data['access_token'];
      print("access token:$accessToken");
      String tokenExpirationDate = response.data['access_token'];
      print("token expiration date:$tokenExpirationDate");
      User user = User.fromJson(response.data['user']);

      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 404) {
      print("Not Found: ${response.statusMessage}");
      return 404;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    } else if (response.statusCode == 401) {
      print("Unauthorized ${response.statusMessage}");
      return 401;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 409;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 401) {
        print("Unauthorized ${e.response!.statusMessage}");
        return 401;
      } else if (e.response!.statusCode == 404) {
        print("Not Found: ${e.response!.statusMessage}");
        return 404;
      }
    }
    print("Dio error occurred: $e");
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 409;
  }
}
