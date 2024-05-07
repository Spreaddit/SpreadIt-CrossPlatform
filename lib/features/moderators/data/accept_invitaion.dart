import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/moderators/data/moderator_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String apibase = apiUrl;

Future<Moderator?> inviteModerator({
  required String communityName,
  required String username,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;

    var apiRoute =
        "/community/moderation/$communityName/$username/accept-invite";
    String apiUrl = apibase + apiRoute;

    final response = await Dio().post(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      Moderator moderator = Moderator.fromJson(responseData);
      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);
      return moderator;
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return null;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return null;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return null;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return null;
  }
}
