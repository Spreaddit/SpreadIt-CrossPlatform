import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../data/report_data_model.dart';

class GetReportedPostsService {
  final String url = '$apiUrl/dashboard/posts';
  final String token =
      UserSingleton().accessToken!; // replace with actual token
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getReportedPosts() async {
    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<dynamic> postData = response.data['reportedPosts'];
        List<Post> posts = postData.map((post) => Post.fromJson(post)).toList();

        List<dynamic>? reportData = response.data['reports'];
        List<Report> reports = reportData != null
            ? reportData.map((report) => Report.fromJson(report)).toList()
            : [];

        return {
          'posts': posts,
          'reports': reports,
        };
      } else {
        throw Exception(
            'Failed to load reported posts: status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load reported posts: $e');
    }
  }
}
