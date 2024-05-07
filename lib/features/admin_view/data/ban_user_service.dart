import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/api.dart';

/// `BanUserService` is a class that provides methods to manage user bans.
///
/// It uses the Dio package to make HTTP requests.
class BanUserService {
  /// Dio instance for making HTTP requests.
  final Dio dio = Dio();

  /// Access token for authentication. Retrieved from the UserSingleton.
  final String accessToken = UserSingleton().accessToken!;

  /// Unbans a user.
  ///
  /// Takes a `username` as a required parameter and sends a POST request to unban the user.
  ///
  /// Returns a `Future<String>` which completes with a response from the server.
  ///
  /// Throws an exception if the request fails.
  Future<String> unbanUser({
    required String username,
  }) async {
    try {
      print(username);
      Map<String, dynamic> data = {
        'username': username,
      };

      final response = await dio.post(
        '$apiUrl/dashboard/unban',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: jsonEncode(data),
      );
      print(response.data['message']);
      return response.data['message'];
    } catch (e) {
      throw Exception('Failed to unban user: $e');
    }
  }

  /// Unbans a user.
  ///
  /// Takes a `username` as a required parameter and sends a POST request to unban the user.
  ///
  /// Returns a `Future<String>` which completes with a response from the server.
  ///
  /// Throws an exception if the request fails.
  Future<String> banUser({
    required String username,
    required String reason,
    DateTime? banDuration,
    required bool isPermanent,
  }) async {
    try {
      Map<String, dynamic> data = {
        'username': username,
        'reason': reason,
        'isPermanent': isPermanent,
      };

      if (banDuration != null) {
        data['banDuration'] = banDuration.toIso8601String();
      }

      final response = await dio.post(
        '$apiUrl/dashboard/ban',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception('Failed to ban user: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to ban user: ${e.response?.data}');
    }
  }
}
