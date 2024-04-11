import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

String apibase = apiUrl;

Future <int> submitPost(
  String title,
  String content,
  String community,
  List pollOptions,
  int selectedDays,
  String? link,
  File? images,
  File? videos,
  bool isSpoiler,
  bool isNSFW,
 ) async {
  try {
    //String? accessToken = userSingleton().accessToken;
    String accessToken = 'chahd';
    const apiRoute = "/posts";
    String apiUrl = apibase + apiRoute;
    String pollVotingLength = selectedDays.toString();
    if (selectedDays == 1) {
      pollVotingLength + ' Day';
    }
    else {
      pollVotingLength + ' Days';
    }
    String? fileType;
    if(images != null) {
      fileType = base64Encode(await images.readAsBytes());
    }
    else if(videos != null) {
      fileType = base64Encode(await videos.readAsBytes());
    }
    else {
      fileType = null;
    }
    final response = await Dio().post(
      apiUrl,
      options:Options(
        headers: {
          'Authorization' :'Bearer $accessToken',
        }
      ),
      data: {
        "title": title,
        "content" : content,
        "community":community,
        "pollOptions":pollOptions,
        "pollVotinglength":pollVotingLength,
        "link":link,
        "fileType":fileType,
        "isSpoiler":isSpoiler,
        "isNSFW":isNSFW,
      }
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
        return 400;
      } else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return 500;
      }
    }
    rethrow;
  } catch(e){
    print("Error occurred: $e");
    return 404;
  }

}