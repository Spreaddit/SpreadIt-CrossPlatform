import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:spreadit_crossplatform/api.dart';

import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/user_info.dart';

Future<int> updateUserApi({
  required String displayName,
  required String aboutUs,
  File? backgroundImage,
  File? profilePicImage,
  String? backgroundImageUrl,
  String? profilePicImageUrl,
  Uint8List? profileImageWeb,
  Uint8List? backgroundImageWeb,
  required List<Map<String, dynamic>> socialMedia,
  required bool contentVisibility,
  required bool showActiveComments,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = '$apiUrl/user/profile-info';
    //String? username = UserSingleton().user!.username;
    String username = 'mimo';
    var data = {
      "username": username,
      "name": displayName,
      "avatar": profilePicImageUrl,
      "banner": backgroundImageUrl,
      "about": aboutUs,
      "socialLinks": socialMedia,
      "isVisible": contentVisibility,
      "isActive": showActiveComments,
    };
    if (backgroundImage != null) {
      List<int> bytes = await backgroundImage.readAsBytes();
      String base64Image = base64Encode(bytes);
      data['banner']=base64Image;
    }

    if (profilePicImage != null) {
      List<int> bytes = await profilePicImage.readAsBytes();
      String base64Image = base64Encode(bytes);
      data['avatar']=base64Image;
    }

    if (profileImageWeb != null) {
      List<int> bytes = profileImageWeb.cast<int>();
      String base64Image = base64Encode(bytes);
      data['avatar']=base64Image;
    }

    if (backgroundImageWeb != null) {
      List<int> bytes = backgroundImageWeb.cast<int>();
      String base64Image = base64Encode(bytes);
      data['banner']=base64Image;
    }

    final response = await Dio().post(
      apiRoute,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 500) {
      print("Server error: ${response.statusMessage}");
      return 500;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on DioException catch (e) {
    print("Dio error occurred: $e");
    return 404;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
