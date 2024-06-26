import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/community/data/mod_permissions.dart';
import 'package:spreadit_crossplatform/user_info.dart';

String baseUrl = apiUrl;
Future<ModPermissions?> fetchPermissionsData(
    String communityName, String username) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    username = UserSingleton().user!.username;
    String apiroute = "/community/$communityName/$username/get-permissions";

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
      ModPermissions permissions = ModPermissions.fromJson(responseData);
      print('permissions: $permissions');
      return permissions;
    } else {
      print(
          'GET fetchPermissionsData request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('fetchPermissionsData Error fetching data: $e');
    Map<String, dynamic> responseData = {
      "managePostsAndComments": false,
      "manageUsers": false,
      "manageSettings": false,
    };
    ModPermissions permissions = ModPermissions.fromJson(responseData);
    return permissions;
  }
}
