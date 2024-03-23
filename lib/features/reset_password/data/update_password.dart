import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

String apibase = apiUrl;

Future<int> updatePassword(
    String newPassword, String currentPassword, String token) async {
  try {
    const apiRoute = "/reset-password";
    String apiUrl = apibase + apiRoute;
    final response = await Dio().post(apiUrl, data: {
      "newPassword": newPassword,
      "currentPassword": currentPassword,
      "token": token
    } // TODO :to be taken from signIn
        );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return 400;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
      return 401;
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
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return 400;
      } else if (e.response!.statusCode == 401) {
        print("Conflict: ${e.response!.statusMessage}");
        return 401;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return 500;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
