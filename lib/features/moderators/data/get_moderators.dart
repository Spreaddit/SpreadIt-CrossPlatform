import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/moderators/data/moderator_class_model.dart';

import 'package:spreadit_crossplatform/user_info.dart';

/*Moderator m1 = Moderator(
    username: 'rehab',
    avatar:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s",
    managePostsAndComments: false,
    manageSettings: true,
    manageUsers: true,
    moderationDate: DateTime.now(),
    communityName: "community name");*/

/*List<Moderator> fetchModeratorsData(String communityName, int display) {
  return [m1, m1, m1];
}*/

Future<List<Moderator>> fetchModeratorsData(
    String communityName, int display) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiroute = '';

    switch (display) {
      case 0: //all
        apiroute = "/community/moderation/$communityName/moderators";
        break;
      case 1: //editable
        apiroute = "/community/moderation/$communityName/moderators/editable";
        break;
    }

    String api = "$apiUrl$apiroute";

    final response = await Dio().get(
      api,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    print("Response status code: ${response.statusCode}");
    print("Response data: ${response.data}");

    if (response.statusCode == 200) {
      List<dynamic> moderatorsJson = response.data;

      print(moderatorsJson);
      List<Moderator> moderators =
          moderatorsJson.map((json) => Moderator.fromJson(json)).toList();

      //print(moderators);
      return moderators;
    } else if (response.statusCode == 404) {
      print("No moderatrs");
      return [];
    } else {
      throw Exception("Failed to fetch moderators: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    if (e.response!.statusCode == 404) {
      print("No moderators");
      return [];
    }
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
