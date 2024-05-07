import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:intl/intl.dart';

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
  DateTime? scheduledDate,
) async {
  try {
    String? accessToken = UserSingleton().accessToken;
    List<PollOptions> pollOptionsData =
        pollOptions.map((option) => PollOptions.fromOption(option)).toList();
    List<Map<String, dynamic>> jsonList =
        pollOptionsData.map((pollOption) => pollOption.toJson()).toList();

    print(pollOptionsData);
    const apiRoute = "/posts";
    String apiUrl = apibase + apiRoute;
    String pollVotingLength = selectedDays.toString();
    if (selectedDays == 1) {
      pollVotingLength += ' Day';
    } else {
      pollVotingLength += ' Days';
    }
    String? fileType;
    int flagMedia = 0;
    if (images != null) {
      flagMedia = 1;
      List<int> bytes = await images.readAsBytes();
      String base64Image = base64Encode(bytes);
      fileType = base64Image;
    } else if (videos != null) {
      flagMedia = 1;
      List<int> bytes = await videos.readAsBytes();
      String base64Image = base64Encode(bytes);
      fileType = base64Image;
    } else if (imageWeb != null) {
      flagMedia = 1;
      List<int> bytes = imageWeb.cast<int>();
      String base64Image = base64Encode(bytes);
      fileType = base64Image;
    } else if (videoWeb != null) {
      flagMedia = 1;
      List<int> bytes = videoWeb.cast<int>();
      String base64Image = base64Encode(bytes);
      fileType = base64Image;
    } else {
      fileType = null;
    }
    if (!(pollOptions.every(
      (element) => element.isEmpty,
    ))) {
      print("poll options chosen");
      flagMedia = 3;
    }
    if (link != null) {
      flagMedia = 2;
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
      if (scheduledDate != null)
        "scheduledDate":
            DateFormat('yyyy-MM-dd HH:mm').format(scheduledDate).toString(),
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
      if (scheduledDate != null)
        "scheduledDate":
            DateFormat('yyyy-MM-dd HH:mm').format(scheduledDate).toString(),
    };

    var dataContent = {
      "title": title,
      "content": content,
      "community": community,
      "type": "Post",
      "fileType": fileType,
      "isSpoiler": isSpoiler,
      "isNSFW": isNSFW,
      if (scheduledDate != null)
        "scheduledDate":
            DateFormat('yyyy-MM-dd HH:mm').format(scheduledDate).toString(),
    };

    var dataMedia = {
      "title": title,
      "content": content,
      "community": community,
      "type": "Images & Video",
      "fileType": fileType,
      "isSpoiler": isSpoiler,
      "isNSFW": isNSFW,
      if (scheduledDate != null)
        "scheduledDate":
            DateFormat('yyyy-MM-dd HH:mm').format(scheduledDate).toString(),
      //TODO:
      //"file": await MultipartFile.fromFile(file.path),
      //     }, FormData.files.add(MapEntry(
      //   'file',
      //   await MultipartFile.fromFile(files[i].path),
      // ));
    };

    Map<String, Object?> postType() {
      switch (flagMedia) {
        case (0):
          return dataContent;
        case (1):
          return dataMedia;
        case (2):
          return dataLink;
        case (3):
          return dataPoll;
        default:
          return dataContent;
      }
    }

    print(postType());
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
