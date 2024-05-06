import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'comment_model_class.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/// Base URL for the API.
String apibase = apiUrl;

/// Updates comments or replies on a post or comment.
///
/// [id]: The ID of the post or comment.
///
/// [content]: The content of the comment or reply.
///
/// [media]: Media associated with the comment or reply.
///
/// [type]: The type of update, either 'comment' or 'reply'.
///
/// Returns the updated comment if successful, otherwise returns null.
Future<Comment?> updateComments({
  required String id,
  required String content,
  File? imageFile,
  Uint8List? imageWeb,
  required String type,
}) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = "";

    switch (type) {
      case 'comment':
        apiRoute = "/post/comment/$id"; //id is the postId in this case
        break;
      case 'reply':
        apiRoute =
            "/comment/$id/reply"; //id is the parent comment Id in this case
        break;
    }
    String apiUrl = apibase + apiRoute;

    if (kIsWeb == true) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.headers['Authorization'] = 'Bearer $accessToken';
        request.fields['content'] = content;

        if (imageWeb != null) {
          request.fields['fileType'] = 'image';
          request.files.add(http.MultipartFile.fromBytes(
            'attachments',
            imageWeb,
            filename: 'image.jpg',
            contentType: MediaType('image', 'jpg'),
          ));
        }

        var response = await request.send();
        if (response.statusCode == 201) {
          Comment receivedComment;
          String responseBody = await response.stream.bytesToString();

          // Decode the JSON response
          Map<String, dynamic> responseData = json.decode(responseBody);

          if (type == 'comment') {
            // Assuming 'comment' is a field in the JSON response
            receivedComment = Comment.fromJson(responseData['comment']);
          } else {
            // Assuming 'reply' is a field in the JSON response
            receivedComment = Comment.fromJson(responseData['reply']);
          }

          print('posted reply $receivedComment');
          print(response.statusCode);

          return receivedComment;
        } else if (response.statusCode == 400) {
          print(response.statusCode);
          return null;
        } else if (response.statusCode == 401) {
          print(response.statusCode);
          return null;
        } else if (response.statusCode == 500) {
          print(response.statusCode);
          return null;
        } else {
          print(response.statusCode);
          return null;
        }
      } on DioException catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400) {
            print(e.response!.statusMessage);
            return null;
          } else if (e.response!.statusCode == 500) {
            print("Conflict: ${e.response!.statusMessage}");
            return null;
          }
        }
        rethrow;
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    } else {
      try {
        var formData = FormData.fromMap({
          "content": content,
          "fileType": "image",
        });

        if (imageFile != null) {
          formData.fields.add(MapEntry('fileType', 'image'));
          formData.files.add(MapEntry(
            'attachments',
            await MultipartFile.fromFile(
              imageFile.path,
              filename: 'image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          ));
        }

        final response = await Dio().post(
          apiUrl,
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
          }),
          data: formData,
        );
        if (response.statusCode == 201) {
          Comment receivedComment;
          if (type == 'comment') {
            receivedComment = Comment.fromJson(response.data['comment']);
          } else {
            receivedComment = Comment.fromJson(response.data['reply']);
          }
          print('posted reply $receivedComment');

          print(response.data);
          print(response.statusCode);
          print(response.statusMessage);
          return receivedComment;
        } else if (response.statusCode == 400) {
          print(response.statusMessage);
          print(response.statusCode);
          return null;
        } else if (response.statusCode == 401) {
          print(response.statusMessage);
          print(response.statusCode);
          return null;
        } else if (response.statusCode == 500) {
          print(response.statusMessage);
          print(response.statusCode);
          return null;
        } else {
          print(response.statusMessage);
          print(response.statusCode);
          return null;
        }
      } on DioException catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400) {
            print(e.response!.statusMessage);
            return null;
          } else if (e.response!.statusCode == 500) {
            print("Conflict: ${e.response!.statusMessage}");
            return null;
          }
        }
        rethrow;
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    }
  } catch (e) {
    print("Error occurred: $e");
    return null;
  }
}
