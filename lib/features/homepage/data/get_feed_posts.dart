import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// describes the way reddit posts are categorized and /or sorted
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
    return "/posts/username/$username";
  }

  if (subspreaditName == null) {
    switch (action) {
      case PostCategories.best:
        return "/home/best/";
      case PostCategories.hot:
        return "/home/hot/";
      case PostCategories.newest:
        return "/home/new/";
      case PostCategories.top:
        return "/home/top/";
      case PostCategories.recent:
        return "/home/posts/"; //TODO: check history page options (Rehab - phase 3)
      case PostCategories.views:
        return "/home/sort/views/";
      case PostCategories.save:
        return "/posts/save/";
      case PostCategories.hide:
        return "/home/posts/hide/";
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
  String? requestURL;
  try {
    String? accessToken = UserSingleton().getAccessToken();

    requestURL = apiUrl +
        postCategoryEndpoint(
          action: category,
          subspreaditName: subspreaditName,
          timeSort: timeSort,
          username: username,
        );
    final response = await Dio().get(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.data);
      List<Post> posts = (response.data['posts'] as List)
          .map((x) => Post.fromJson(x))
          .toList();
      return (posts);
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
    return [];
  } on DioException catch (e) {
    print("URL: $requestURL");
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

/// Takes [PostCategories] as a paremeter
/// and fetches its respective [Post] List
Future<Post?> getPostById({
  required String postId,
}) async {
  try {
    String? accessToken = UserSingleton().getAccessToken();

    String requestURL = "$apiUrl/posts/$postId/";

    final response = await Dio().get(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(response.data);
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
    return null;
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
      } else {
        print("Internal Server Error: ${e.response!.statusMessage}");
      }
      return null;
    }
    rethrow;
  } catch (e) {
    //TO DO: show error message to user
    print("Error occurred: $e");
    return null;
  }
}
