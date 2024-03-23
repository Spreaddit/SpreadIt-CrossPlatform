import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';

enum PostCategories {
  best,
  hot,
  newposts,
  top,
  random,
  recent,
}

String postCategoryEndpoint(PostCategories action) {
  switch (action) {
    case PostCategories.best:
      return "/best/best/";
    case PostCategories.hot:
      return "/best/hot/";
    case PostCategories.newposts:
      return "/best/new/";
    case PostCategories.top:
      return "/best/top/";
    case PostCategories.random:
      return "/best/random/";
    case PostCategories.recent:
      return "/best/recent-posts/";
  }
}

Future<List<Post>> getFeedPosts(PostCategories category) async {
  try {
    String requestURL = apiUrl + postCategoryEndpoint(category);
    final response = await Dio().get(requestURL);
    if (response.statusCode == 200) {
      return (response.data as List).map((x) => Post.fromJson(x)).toList();
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
