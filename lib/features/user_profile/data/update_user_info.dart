import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
    String? username = UserSingleton().user!.username;
    if (kIsWeb) {
      var request = http.MultipartRequest('PUT', Uri.parse(apiRoute));
      request.headers['Authorization'] = 'Bearer $accessToken';

      request.fields['username'] = username;
      request.fields['name'] = displayName;
      request.fields['about'] = aboutUs;
      request.fields['isVisible'] = contentVisibility.toString();
      request.fields['isActive'] = showActiveComments.toString();

      if (profileImageWeb != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'avatar',
          profileImageWeb,
          filename: 'avatar.jpg',
          contentType: MediaType('image', 'jpg'),
        ));
      }

      if (backgroundImageWeb != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'banner',
          backgroundImageWeb,
          filename: 'banner.jpg',
          contentType: MediaType('image', 'jpg'),
        ));
      }
      if (profileImageWeb == null && profilePicImage == null) {
        request.fields['avatar'] = profilePicImageUrl!;
      }

      if (backgroundImage == null && backgroundImageWeb == null) {
        request.fields['banner'] = backgroundImageUrl!;
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully');
        return 200;
      } else if (response.statusCode == 500) {
        print('Server error: ${response.reasonPhrase}');
        return 500;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return 404;
      }
    } else {
      var formData = FormData.fromMap({
        'username': username,
        'name': displayName,
        'about': aboutUs,
        'isVisible': contentVisibility,
        'isActive': showActiveComments,
      });

      if (profilePicImage != null) {
        formData.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(
            profilePicImage.path,
            filename: 'avatar.jpg',
            contentType: MediaType('image', 'jpg'),
          ),
        ));
      }

      if (backgroundImage != null) {
        formData.files.add(MapEntry(
          'banner',
          await MultipartFile.fromFile(
            backgroundImage.path,
            filename: 'banner.jpg',
            contentType: MediaType('image', 'jpg'),
          ),
        ));
      }
      if (profilePicImage == null) {
        formData.fields.add(MapEntry(
          'avatar',
          profilePicImageUrl!,
        ));
      }

      if (backgroundImageWeb == null) {
        formData.fields.add(MapEntry(
          'banner',
          backgroundImageUrl!,
        ));
      }
      final response = await Dio().put(
        apiRoute,
        data: formData,
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
    }
  } catch (e) {
    print('Error occurred: $e');
    return 1;
  }
}
