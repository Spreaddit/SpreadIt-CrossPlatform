import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';

/// describes the way reddit posts are categorized and/or sorted
enum PostCategories {
  best,
  hot,
  newest,
  top,
  random,
  recent,
  views,
  user,
  save,
  hide,
}

/// takes [PostCategories] as a parameter and
/// returns its respective endpoint
String postCategoryEndpoint({
  required PostCategories action,
  String? subspreaditName,
  String? timeSort = "",
  String? username = "",
}) {
  if (action == PostCategories.user) {
    return "/posts/$username";
  }

  if (subspreaditName == null) {
    switch (action) {
      case PostCategories.best:
        return "/best/";
      case PostCategories.hot:
        return "/hot/";
      case PostCategories.newest:
        return "/new/";
      case PostCategories.top:
        return "/top/";
      case PostCategories.recent:
        return "/posts/"; //TODO: check history page options (Rehab - phase 3)
      case PostCategories.views:
        return "/sort/views/";
      case PostCategories.save:
        return "/posts/save/";
      case PostCategories.hide:
        return "/posts/hide/";
      default:
        return "";
    }
  } else {
    switch (action) {
      case PostCategories.hot:
        return "/subspreadit/$subspreaditName/hot/";
      case PostCategories.newest:
        return "/subspreadit/$subspreaditName/new/";
      case PostCategories.top:
        return "/subspreadit/$subspreaditName/top/$timeSort";
      case PostCategories.random:
        return "/subspreadit/$subspreaditName/random/";
      default:
        return "";
    }
  }
}

/// Takes [PostCategories] as a paremeter
/// and fetches its respective [Post] List
Future<List<Post>> getFeedPosts({
  required PostCategories category,
  String? subspreaditName,
  String? timeSort = "",
  String? username = "",
}) async {
  try {
    String requestURL = apiUrl +
        postCategoryEndpoint(
          action: category,
          subspreaditName: subspreaditName,
          timeSort: timeSort,
          username: username,
        );
    print("post Category Endpoint: $requestURL");
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
