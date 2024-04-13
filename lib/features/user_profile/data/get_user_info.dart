import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import './class_models/user_info_class_model.dart';

String baseUrl = apiUrl;

Future<UserInfo> fetchUserInfo(String username) async {
    try {
      String? accessToken=UserSingleton().accessToken;
      const apiroute = "/user/profile-info";
      String apiUrl = "$baseUrl$apiroute/$username";

      final response = await Dio().get(apiUrl ,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),);
      if (response.statusCode == 200) {
        return UserInfo.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Error token is required: ${response.statusMessage}");
      } else if (response.statusCode == 404) {
        throw Exception("User not found: ${response.statusMessage}");
      } else if (response.statusCode == 500) {
        throw Exception("Server error: ${response.statusMessage}");
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          throw Exception("Error token is required: ${e.response!.statusMessage}");
        } else if (e.response!.statusCode == 404) {
          throw Exception("User not found: ${e.response!.statusMessage}");
        } else if (e.response!.statusCode == 500) {
          throw Exception("Server error: ${e.response!.statusMessage}");
        }
      }
      throw Exception("Dio error occurred: $e");
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
