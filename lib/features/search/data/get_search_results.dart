import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// This function interacts with the backend to get the search results from the homepage .
/// It takes the query to search for, the type of results to be retrieved (posts, comments,communities or users) and the sorting filter if any

class GetSearchResults {
  Dio dio = Dio();
  String? accessToken = UserSingleton().accessToken;
  String apibase = apiUrl;

  Future <Map<String,dynamic>> getSearchResults(String query, String type, String sort) async {
    try {
      print('query: $query, type: $type, sort: $sort');
      String? accessToken = UserSingleton().accessToken;
      var response = await Dio().get(
        '$apibase/search',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        queryParameters: {
          'q': query,
          'type': type,
          'sort': sort,
        },
      );
      if (response.statusCode == 200) {
        print(response.statusMessage);
        print(response.statusCode);
        return (response.data);
      } else {
        print(response.statusMessage);
        print(response.statusCode);
        return {};
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          print(e.response!.statusMessage);
        } else if (e.response!.statusCode == 500) {
          print("Conflict: ${e.response!.statusMessage}");
        }
        return {};
      }
      rethrow;
    } catch (e) {
      print("Error occurred: $e");
      return {};
    }
  }
}


