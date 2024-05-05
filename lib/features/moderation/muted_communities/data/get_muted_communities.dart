import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/user_info.dart';

import 'package:dio/dio.dart';

/// A class for retrieving a list of muted communities for the current user.
class GetMutedCommunities {
  Dio dio = Dio();
  String? accessToken = UserSingleton().accessToken;

  /// Retrieves a list of muted communities for the current user.
  ///
  /// Sends a GET request to the server to fetch the list of muted communities.
  /// Uses the access token of the current user for authorization.
  ///
  /// Returns a Future<List<Community>> representing the list of muted communities.
  /// If successful, the list will contain instances of [Community] class.
  ///
  /// Throws an [Exception] if any error occurs during the process.
  /// Possible error scenarios include:
  /// - User not found (status code 404)
  /// - Unauthorized access (status code 401)
  /// - Internal server error (status code 500)
  /// - Bad request with invalid request parameters (status code other than 200, 404, 401, 500)
  /// - Dio related errors
  ///
  /// Example usage:
  /// ```dart
  /// GetMutedCommunities mutedCommunities = GetMutedCommunities();
  /// try {
  ///   List<Community> communities = await mutedCommunities.getMutedCommunities();
  ///   communities.forEach((community) {
  ///     print('Muted community: ${community.name}');
  ///   });
  /// } catch (e) {
  ///   print('Error occurred: $e');
  /// }
  /// ```
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
        List<Community> communities =
            (response.data as List).map((i) => Community.fromJson(i)).toList();
        return communities;
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception('Bad request, invalid request parameters');
      }
    } catch (e) {
      throw Exception('Failed to load communities: $e ');
    }
  }
}
