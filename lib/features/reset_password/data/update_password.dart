import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

/// This page receives the user input passwords which are [currentPassword], [newPassword] and a [token] for the user request, and
/// sends all thede data to the backend.
/// the backend first checks that the [currentPassword] is indeed connected to this user and then updated the
/// [currentPassword] with the [newPassword].

Future<int> updatePassword(
    String newPassword, String currentPassword, String token) async {
  try {
    const apiRoute = "/reset-password";
    String apiUrl = apibase + apiRoute;
    String? accessToken = UserSingleton().accessToken;
    final response = await Dio().post(apiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
        data: {
          "newPassword": newPassword,
          "currentPassword": currentPassword,
          "token": accessToken,
        });
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
