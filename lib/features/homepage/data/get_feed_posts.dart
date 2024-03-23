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
    return (response.data as List).map((x) => Post.fromJson(x)).toList();
  } catch (error, stacktrace) {
    throw Exception("Exception occured: $error stackTrace: $stacktrace");
  }
}
