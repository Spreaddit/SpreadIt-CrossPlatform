import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

class IsUserModeratorService {
  final Dio dio = Dio();

  IsUserModeratorService();

  Future<bool> isUserModerator(String communityName) async {
    String username = UserSingleton().user?.username ?? '';
    String? accessToken = UserSingleton().accessToken;
    Options options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    try {
      final response = await dio.get(
        '$apiUrl/$communityName/$username/is-moderator',
        options: options,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return data['isModerator'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return false;
    }
  }
}
