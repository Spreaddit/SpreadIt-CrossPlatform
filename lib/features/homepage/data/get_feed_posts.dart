import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';

enum PostCategories { best, hot, recent, top, random }

String postCategoryEndpoint(PostCategories action) {
  switch (action) {
    case PostCategories.best:
      return "best/best/";
    case PostCategories.hot:
      return "best/hot/";
    case PostCategories.recent:
      return "best/recent/";
    case PostCategories.top:
      return "best/top/";
    case PostCategories.random:
      return "best/random/";
  }
}

Future<List<Post>> getFeedPosts(PostCategories category) async {
  try {
    String requestURL = apiURL() + postCategoryEndpoint(category);
    final response = await Dio().get(requestURL);
    return (response.data as List).map((x) => Post.fromJson(x)).toList();
  } catch (error, stacktrace) {
    throw Exception("Exception occured: $error stackTrace: $stacktrace");
  }
}
