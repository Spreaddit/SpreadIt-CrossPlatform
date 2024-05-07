import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
/// Fetches recommended community data.
///
/// This function sends a GET request to the backend API to fetch recommended
/// community data for the user. It requires an access token for authentication.
///
/// Returns a Future that resolves to a Notifications object containing the
/// recommended community data if the request is successful.
///
/// Throws an exception with an error message if the request fails or encounters
/// an error, including the following cases:
/// - 404: No recommended communities found.
/// - 500: Internal server error.
/// - Any other error encountered during the request process.
///
/// Example usage:
///
/// ```dart
/// try {
///   Notifications recommendedCommunity = await getRecommendedCommunity();
///   // Handle recommendedCommunity data
/// } catch (e) {
///   // Handle error
///   print('Failed to fetch recommended community data: $e');
/// }
/// ```

Future<Notifications> getRecommendedCommunity() async {
  try {
    String? accessToken = UserSingleton().accessToken;

    final response = await Dio().get(
      '$apiUrl/community/suggest',
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
      Notifications community = Notifications.fromJson(response.data);
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
