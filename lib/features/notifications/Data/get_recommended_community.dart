import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

String baseUrl = "http://192.168.1.4:3001/MOHAMEDREFAAT031/Notification/2.0.0";

Future<Community> getRecommendedCommunity() async {
  try {
    String? accessToken = UserSingleton().accessToken;

    final response = await Dio().get(
      '$baseUrl/community/suggest',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(
        "reponse ${response.data}",
      );
      Community community = Community.fromJson(response.data);
      print(community);
      return community;
    } else if (response.statusCode == 404) {
      throw Exception("There aren't any recommended community");
    } else if (response.statusCode == 500) {
      throw Exception('Internal server error');
    } else {
      throw Exception('Bad request, invalid request paramters');
    }
  } catch (e) {
    throw Exception('Failed to load communities: $e ');
  }
}
