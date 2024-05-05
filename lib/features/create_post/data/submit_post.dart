import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// This function takes all the post parameters such as [title], [content], [link], [image], [video], [poll],and [tags]to submit them to the backend.
/// The parameters are: 
/// 1) [title] : the post title.
/// 2) [content] : the text content (body).
/// 3) [community] : the name of the community the post is post to.
/// 4) [pollOptions] : a list containing the poll options created by the user.
/// 5) [selectedDays] : how long th epoll will be available for voting.
/// 6) [link] : a url to a page.
/// 7) [images] : images uploaded by the user on mobile.
/// 8) [imageWeb] : images uploaded by the user on web.
/// 9) [videos] : the videos uploaded by the user on mobile.
/// 10) [videoWeb] : the videos uploaded by the user on web.
/// 11) [isSpoiler] : a boolean to indicate if the post is marked as spoiler.
/// 12) [isNSFW] : a boolean to indicate if the post is marked as NSFW.

String apibase = apiUrl;

Future<int> submitPost(
  String title,
  String content,
  String community,
  List pollOptions,
  int selectedDays,
  String? link,
  File? images,
  Uint8List? imageWeb,
  File? videos,
  Uint8List? videoWeb,
  bool isSpoiler,
  bool isNSFW,
) async {
    String? accessToken = UserSingleton().accessToken;
    const apiRoute = "/posts";
    String apiUrl = apibase + apiRoute;
  if (images == null && imageWeb == null && videos == null && videoWeb == null) {
      try {
        List<PollOptions> pollOptionsData =
            pollOptions.map((option) => PollOptions.fromOption(option)).toList();
        List<Map<String, dynamic>> jsonList =
            pollOptionsData.map((pollOption) => pollOption.toJson()).toList();

        String pollVotingLength = selectedDays.toString();
        if (selectedDays == 1) {
          pollVotingLength += ' Day';
        } else {
          pollVotingLength += ' Days';
        }
        
        int flagMedia = 0;
        String? fileType = null;
        if (!(pollOptions.every((element) => element.isEmpty,))) {
          print("poll options chosen");
          flagMedia = 2;
        }
        if (link != null) {
          flagMedia = 1;
        }

        var dataPoll = {
          "title": title,
          "content": content,
          "community": community,
          "pollOptions": jsonList,
          "pollVotingLength": pollVotingLength,
          "type": "Poll",
          "fileType": fileType,
          "isSpoiler": isSpoiler,
          "isNSFW": isNSFW,
        };

        var dataLink = {
          "title": title,
          "content": content,
          "community": community,
          "link": link,
          "type": "Link",
          "fileType": fileType,
          "isSpoiler": isSpoiler,
          "isNSFW": isNSFW,
        };

        var dataContent = {
          "title": title,
          "content": content,
          "community": community,
          "type": "Post",
          "fileType": fileType,
          "isSpoiler": isSpoiler,
          "isNSFW": isNSFW,
        };

        Map<String, Object?> postType() {
          switch (flagMedia) {
            case (0):
              return dataContent;
            case (1):
              return dataLink;
            case (2):
              return dataPoll;
            default:
              return dataContent;
            }
        }

        final response = await Dio().post(
          apiUrl,
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
          }),
          data: postType(),
          );
          if (response.statusCode == 201) {
            print(response.data);
            print(response.statusCode);
            print(response.statusMessage);
            return 201;
          } else if (response.statusCode == 400) {
            print(response.statusMessage);
            print(response.statusCode);
            return 400;
          } else if (response.statusCode == 500) {
            print(response.statusMessage);
            print(response.statusCode);
            return 500;
          } else {
            print(response.statusMessage);
            print(response.statusCode);
            return 404;
          }
          } on DioException catch (e) {
          if (e.response != null) {
            if (e.response!.statusCode == 400) {
              print(e.response!.statusMessage);
              print(e.response?.data);
              return 400;
            } else if (e.response!.statusCode == 500) {
              print("Conflict: ${e.response!.statusMessage}");
              return 500;
            }
        }
        rethrow;
      } catch (e) {
        print("Error occurred: $e");
        return 404;
      }
  }

  else if (kIsWeb == true && (imageWeb != null || videoWeb != null)) {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['community'] = community;
      request.fields['type'] = 'Images & Video';
      request.fields['isSpoiler'] = isSpoiler.toString();
      request.fields['isNSFW'] = isNSFW.toString();

      if (imageWeb != null) {
      request.fields['fileType'] = 'image';
      request.files.add(http.MultipartFile.fromBytes(
        'attachments',
        imageWeb,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpg'),
      ));
    }

    if (videoWeb != null) {
      request.fields['fileType'] = 'video';
      request.files.add(http.MultipartFile.fromBytes(
        'attachments',
        videoWeb,
        filename: 'video.mp4',
        contentType: MediaType('video', 'mp4'),
      ));
    }

      var response = await request.send();

      if (response.statusCode == 201) {
        print(response.statusCode);
        return 201;
      } else if (response.statusCode == 400) {
        print(response.statusCode);
        return 400;
      } else if (response.statusCode == 500) {
        print(response.statusCode);
        return 500;
      } else {
        print(response.statusCode);
        return 404;
      }
    } catch (e) {
      print('Error occurred: $e');
      return 404;
    }
  }
  else {
   try{
      var formData = FormData.fromMap({
        "title": title,
        "content": content,
        "community": community,
        "type": "Images & Video",
        "isSpoiler": isSpoiler,
        "isNSFW": isNSFW,
      });

      if (images != null) {
        formData.fields.add(MapEntry('fileType','image'));
        formData.files.add(MapEntry(
          'attachments',
          await MultipartFile.fromFile(
            images.path,
            filename: 'image.jpg',
            contentType: MediaType('image', 'jpg'),
          ),
        ));
      }
      if (videos != null) {
        formData.fields.add(MapEntry('fileType','video'));
        formData.files.add(MapEntry(
          'attachments',
          await MultipartFile.fromFile(
            videos.path,
            filename: 'video.mp4',
            contentType: MediaType('video', 'mp4'),
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
        print(response.data);
        print(response.statusCode);
        print(response.statusMessage);
        return 201;
      } else if (response.statusCode == 400) {
        print(response.statusMessage);
        print(response.statusCode);
        return 400;
      } else if (response.statusCode == 500) {
        print(response.statusMessage);
        print(response.statusCode);
        return 500;
      } else {
        print(response.statusMessage);
        print(response.statusCode);
        return 404;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          print(e.response!.statusMessage);
          print(e.response?.data);
          return 400;
        } else if (e.response!.statusCode == 500) {
          print("Conflict: ${e.response!.statusMessage}");
          return 500;
        }
      }
      rethrow;
    } catch (e) {
      print("Error occurred: $e");
      return 404;
    }
  }
}












