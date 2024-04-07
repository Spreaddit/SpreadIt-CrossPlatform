import 'dart:convert';
import 'dart:io';
import 'package:spreadit_crossplatform/api.dart';

import 'package:dio/dio.dart';

Future<int> updateUserApi({
  required String accessToken,
  required String username,
  required String aboutUs,
  required dynamic backgroundImage, // Accepts either a file or a string (URL)
  required dynamic profilePicImage, // Accepts either a file or a string (URL)
  required List<String> socialMedia,
  required bool contentVisibility,
  required bool showActiveComments,
}) async {
  try {
    String apiRoute = '$apiUrl/user/update?accessToken=$accessToken';

    var formData = FormData();

    formData.fields.addAll([
      MapEntry('username', username),
      MapEntry('aboutUs', aboutUs),
      MapEntry('socialMedia', jsonEncode(socialMedia)),
      MapEntry('contentVisibility', contentVisibility.toString()),
      MapEntry('showActiveComments', showActiveComments.toString()),
    ]);

    if (backgroundImage is String) {
      formData.fields.add(MapEntry('backgroundImageUrl', backgroundImage));
    } else if (backgroundImage is File) {
      formData.files.add(MapEntry('backgroundImage', await MultipartFile.fromFile(
        backgroundImage.path,
        filename: backgroundImage.path.split('/').last,
      )));
    } else {
      throw ArgumentError('backgroundImage must be either a string (URL) or a file (FormData)');
    }

    if (profilePicImage is String) {
      formData.fields.add(MapEntry('profilePicImageUrl', profilePicImage));
    } else if (profilePicImage is File) {
      formData.files.add(MapEntry('profilePicImage', await MultipartFile.fromFile(
        profilePicImage.path,
        filename: profilePicImage.path.split('/').last,
      )));
    } else {
      throw ArgumentError('profilePicImage must be either a string (URL) or a file (FormData)');
    }

    final response = await Dio().post(apiRoute, data: formData);

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
