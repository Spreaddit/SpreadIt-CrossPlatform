import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

const apiUrl =
    "http://localhost:3006/FAROUQDIAA52/Module9V2/1.0.0"; //EMSA7eeehaaaaaaaaaaaaa
String apibase = apiUrl;

Future<void> updatePermissions({
  required String communityName,
  required String username,
  required bool managePostsAndComments,
  required bool manageUsers,
  required bool manageSettings,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    var apiRoute = "/community/moderation/$communityName/$username/permissions";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().put(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
      data: {
        "managePostsAndComments": managePostsAndComments,
        "manageUsers": manageUsers,
        "manageSettings": manageSettings,
      },
    );

    if (response.statusCode == 200) {
      print("$managePostsAndComments,$manageUsers,$manageSettings");
      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);

      return;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return;
  }
}
