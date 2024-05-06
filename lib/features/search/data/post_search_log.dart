import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

/// It takes the [] from the input field and sends it to the backend to ensure that this user exists and send them an
/// email with the password

Future<int> postSearchLog(String query,String type, String? communityName, String? username, bool isInProfile) async {
  try {
    const apiRoute = "/search/log";
    String apiUrl = apibase + apiRoute;
    String? accessToken = UserSingleton().accessToken;
    final response = await Dio().post(apiUrl,
      options:Options(
        headers: {
          'Authorization' :'Bearer $accessToken',
        }
      ),
     data: {
      "query": query,
      "type": type,
      "communityName": communityName,
      "username": username,
      "isInProfile": isInProfile,
     },
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print('log ${response.statusCode}');
      return 400;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print('log ${response.statusCode}');
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
