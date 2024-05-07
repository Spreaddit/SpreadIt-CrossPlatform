import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/post_settings_model_class.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = apiUrl;

/// Updates the post settings for a community.
///
/// [updatedSettings]: The updated post settings.
/// [communityName]: The name of the community.
Future<void> updatePostSettings(
    PostSettings updatedSettings, String communityName) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiroute = "/community/$communityName/settings";

    String apiUrl = "$baseUrl$apiroute";

    Response response = await Dio().put(apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: updatedSettings.toJson());

    if (response.statusCode == 200) {
      print('Data updated successfully');
    } else if (response.statusCode == 400) {
      print(response.statusMessage);
      print(response.statusCode);
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      print(response.statusCode);
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
    } else {
      print(response.statusMessage);
      print(response.statusCode);
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
  }
}
