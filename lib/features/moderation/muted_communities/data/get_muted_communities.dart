import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/user_info.dart';

import 'package:dio/dio.dart';
class GetMutedCommunities {
  Dio dio = Dio();
  String? accessToken = UserSingleton().accessToken;
  Future<List<Community>> getMutedCommunities() async {
    try {

      Response response;
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      
        response = await dio.get(
          '$apiUrl/community/muted',
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
        throw Exception('User not found');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
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
