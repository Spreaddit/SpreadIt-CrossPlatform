import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// This function interacts with the backend to get the seaarch history of the user.

String apibase = apiUrl;

Future<List> getSeacrhHistory() async {
  try {
    String? accessToken = UserSingleton().accessToken;
    var response = await Dio().get(
      '$apiUrl/search/history',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      print(response.statusCode);
      print(response.data);
      return (response.data);
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
      }
      return [];
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return [];
  }
}



