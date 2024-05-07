import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// This function interacts with the backend to get the trending posts for today.


class GetTrendingPosts {
  Dio dio = Dio();
  String? accessToken = UserSingleton().accessToken;

  String apibase = apiUrl;

  Future <Map<String,dynamic>> getTrendingPosts() async {
    try {
      String? accessToken = UserSingleton().accessToken;
      var response = await Dio().get(
        '$apiUrl/search/trending',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response.statusMessage);
        print(response.statusCode);
        //print(response.data);
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


