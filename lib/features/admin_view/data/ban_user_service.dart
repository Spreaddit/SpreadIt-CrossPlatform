import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/api.dart';

class BanUserService {
  final Dio dio = Dio();
  final String accessToken = UserSingleton().accessToken!;

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
