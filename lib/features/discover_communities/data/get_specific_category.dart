import 'package:spreadit_crossplatform/user_info.dart';

import 'community.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

class GetSpecificCommunity {
  Dio dio = Dio();
  String? accessToken = UserSingleton().accessToken;
  Future<List<Community>> getCommunities(String category) async {
    try {
      Response response;
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (category == '🔥 Trending globally' || category == '🌍 Top globally') {
        response = await dio.get(
          '$apiUrl/community/random-category',
          options: options,
        );
      } else {
        response = await dio.get(
          '$apiUrl/community/get-specific-category',
          queryParameters: {
            'category': category,
          },
          options: options,
        );
      }

      if (response.statusCode == 200) {
        print(
          "reponse ${response.data}",
        );
        List<Community> communities =
            (response.data as List).map((i) => Community.fromJson(i)).toList();

        return communities;
      } else if (response.statusCode == 404) {
        throw Exception('No communities found for the specified category');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception('Bad request, invalid request paramters');
      }
    } catch (e) {
      throw Exception('Failed to load communities: $e ');
    }
  }
}
