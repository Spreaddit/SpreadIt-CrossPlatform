import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';



Future<List<Post>> getSavedPosts(String username, String page) async {
  try {
        String apiroute='';
    switch (page) {
    case 'saved':
      apiroute = "/posts/saved/user";
      break;
    case 'user':
      apiroute = "/posts/user"; 
      break;
  }
    String requestURL = "$apiUrl$apiroute/$username";

    final response = await Dio().get(requestURL);
    if (response.statusCode == 200) {
      var ayhaga= (response.data as List).map((x) => Post.fromJson(x)).toList();
      print('hello');
      return ayhaga;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
    return [];
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
      } else {
        print("Internal Server Error: ${e.response!.statusMessage}");
      }
      return [];
    }
    rethrow;
  } catch (e) {
    //TO DO: show error message to user
    print("Error occurred: $e");
    return [];
  }
}
