import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

String apibase = apiUrl;

Future <int> submitPost(
  String title,
  String content,
  String community,
  List pollOptions,
  String pollVotingLength,
  String link,
  String images,
  String videos,
  bool isSpoiler,
  bool isNSFW,
 ) async {
  try {
    const apiRoute = "/reset-password";
    String apiUrl = apibase + apiRoute;
    final response = await Dio().post(apiUrl, data: {
      "title": title,
      "content" : content,
      "community":community,
      "pollOptions":pollOptions,
      "pollVotinglength":pollVotingLength,
      "link":link,
      "images":images,
      "videos":videos,
      "isSpoiler":isSpoiler,
      "isNSFW":isNSFW,
     }
   );
   if (response.statusCode == 201) {
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