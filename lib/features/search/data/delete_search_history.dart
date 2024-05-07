import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// This function interacts with the backend to delete a search history given the query.

String apibase = apiUrl;

Future<int> deleteSearchHistory(String query) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    var response = await Dio().get(
      '$apiUrl/search/history',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      queryParameters: {
        'query': query,
      }
    );
    if (response.statusCode == 200) {
      print(response.statusMessage);
      print('search history deleted');
      print(response.statusCode);
      return 200;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return 500;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 500) {
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
