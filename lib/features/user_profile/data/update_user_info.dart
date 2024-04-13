import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:spreadit_crossplatform/api.dart'; // Importing the API configuration.
import 'package:dio/dio.dart'; // Importing the Dio package.
import 'package:spreadit_crossplatform/user_info.dart'; // Importing user information.

/// Updates user information via API request.
///
/// This function updates user information by sending a PUT request to the server
/// with the updated user data. It handles different response status codes accordingly.
///
/// Parameters:
///   - displayName: The updated display name of the user.
///   - aboutUs: The updated 'about' information of the user.
///   - backgroundImage: The updated background image file (if applicable).
///   - profilePicImage: The updated profile picture file (if applicable).
///   - backgroundImageUrl: The URL of the updated background image.
///   - profilePicImageUrl: The URL of the updated profile picture.
///   - profileImageWeb: The updated profile picture as Uint8List for web.
///   - backgroundImageWeb: The updated background image as Uint8List for web.
///   - socialMedia: The list of updated social media links.
///   - contentVisibility: The updated content visibility status.
///   - showActiveComments: The updated status to show active comments.
///
/// Returns:
///   - A Future<int> representing the HTTP status code of the request:
///     - 200 if successful.
///     - 500 if a server error occurs.
///     - 404 if an unexpected status code is received or an error occurs.
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
    /// Retrieve the access token from the user singleton instance.
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = '$apiUrl/user/profile-info';
    String? username = UserSingleton().user!.username;
    
    /// Prepare the data to be sent in the request for backend.
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
    
    /// Convert image files to base64 strings if available.
    if (backgroundImage != null) {
      List<int> bytes = await backgroundImage.readAsBytes();
      String base64Image = base64Encode(bytes);
      data['banner'] = base64Image;
    }

    if (profilePicImage != null) {
      List<int> bytes = await profilePicImage.readAsBytes();
      String base64Image = base64Encode(bytes);
      data['avatar'] = base64Image;
    }

    if (profileImageWeb != null) {
      List<int> bytes = profileImageWeb.cast<int>();
      String base64Image = base64Encode(bytes);
      data['avatar'] = base64Image;
    }

    if (backgroundImageWeb != null) {
      List<int> bytes = backgroundImageWeb.cast<int>();
      String base64Image = base64Encode(bytes);
      data['banner'] = base64Image;
    }

    /// Send a PUT request to the server to update user information.
    final response = await Dio().put(
      apiRoute,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    /// Process the response based on the status code.
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
    /// Handle Dio exceptions and return 404.
    print("Dio error occurred: $e");
    return 404;
  } catch (e) {
    /// Handle other exceptions and return 404.
    print("Error occurred: $e");
    return 404;
  }
}
