import 'package:spreadit_crossplatform/user_info.dart';

import '../../discover_communities/data/community.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

class GetAllCommunities {
  Dio dio = Dio();
  Future<List<Community>> getAllCommunities() async {
    try {
      String? accessToken = UserSingleton().accessToken;
      Response response;
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      response = await dio.get(
        '$apiUrl/community/list',
        options: options,
      );

      if (response.statusCode == 200) {
        print(
          "reponse ${response.data}",
        );
        List<Community> communities =
            (response.data as List).map((i) => Community.fromJson(i)).toList();
        print(communities);
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