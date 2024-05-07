import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Updates user profile information on the server.
///
/// This function sends a PUT request to the server to update the user's profile information,
/// including display name, about section, social media links, and profile/background images.
///
/// Returns a status code indicating the success or failure of the update operation.
///
/// - [displayName]: The new display name of the user.
/// - [aboutUs]: The new about section of the user profile.
/// - [backgroundImage]: The new background image file.
/// - [profilePicImage]: The new profile picture image file.
/// - [backgroundImageUrl]: The URL of the existing background image.
/// - [profilePicImageUrl]: The URL of the existing profile picture.
/// - [profileImageWeb]: The new profile picture image data for web platforms.
/// - [backgroundImageWeb]: The new background image data for web platforms.
/// - [socialMedia]: A list of maps containing social media links.
/// - [contentVisibility]: Indicates whether the user's content is visible.
/// - [showActiveComments]: Indicates whether to show active comments.
///
/// Throws an exception if an error occurs during the process.
///
/// Example usage:
/// ```dart
/// int statusCode = await updateUserApi(
///   displayName: 'John Doe',
///   aboutUs: 'Flutter developer',
///   backgroundImage: File('path/to/background_image.jpg'),
///   profilePicImage: File('path/to/profile_pic_image.jpg'),
///   backgroundImageUrl: 'https://example.com/background_image.jpg',
///   profilePicImageUrl: 'https://example.com/profile_pic_image.jpg',
///   profileImageWeb: profileImageData,
///   backgroundImageWeb: backgroundImageData,
///   socialMedia: [
///     {'platform': 'Twitter', 'link': 'https://twitter.com/example'},
///     {'platform': 'LinkedIn', 'link': 'https://linkedin.com/example'},
///   ],
///   contentVisibility: true,
///   showActiveComments: false,
/// );
/// ```
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
  required bool showActiveCommunity,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = '$apiUrl/user/profile-info';
    String? username = UserSingleton().user!.username;
    var data = {
      "username": username,
      "name": displayName,
      "avatar": profilePicImageUrl,
      "banner": backgroundImageUrl,
      "about": aboutUs,
      "socialLinks": socialMedia,
      "isVisible": contentVisibility,
      "isActive": showActiveCommunity,
    };
    final response = await Dio().put(
      apiRoute,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode != 200) {
      print("An error occured");
      return response.statusCode!;
    }
    if (kIsWeb && (profileImageWeb != null || backgroundImageWeb != null)) {
      var request = http.MultipartRequest('PUT', Uri.parse(apiRoute));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['username'] = username;
      request.fields['name'] = displayName;
      request.fields['about'] = aboutUs;

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
    } else if (profilePicImage != null || backgroundImage != null) {
      var formData = FormData.fromMap({
        'username': username,
        'name': displayName,
        'about': aboutUs,
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

      if (backgroundImage == null) {
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
    return 200;
  } catch (e) {
    print('Error occurred: $e');
    return 1;
  }
}
