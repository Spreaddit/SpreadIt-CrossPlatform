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

void getFeedPosts(PostCategories category) async {
  try {
    String requestURL = apiURL() + postCategoryEndpoint(category);
    final response = await Dio().get(requestURL);
    if (response.statusCode == 200) {
      //TO DO: implement logic needed to re-render UI
      print(response.data);
    } else {
      //TO DO: show error message to user
      print(response.statusCode);
    }
  } catch (e) {
    //TO DO: show error message to user
    print(e);
  }
}
