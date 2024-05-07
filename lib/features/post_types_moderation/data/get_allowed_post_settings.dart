import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/post_settings_model_class.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = apiUrl;

/// Fetches post settings data for a given community.
///
/// Retrieves the post settings for the specified [communityName].
/// Returns a [PostSettings] object if the request is successful, otherwise returns null.
///
/// Throws an error if the request fails.
Future<PostSettings?> fetchPostSettingsData(String communityName) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiroute = "/community/$communityName/settings";

    String apiUrl = "$baseUrl$apiroute";

    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      PostSettings settings = PostSettings.fromJson(responseData);
      print('Settings: $settings');
      return settings;
    } else {
      print('GET request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching data: $e');
    return null;
  }
}
