import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../data/report_data_model.dart';

/// `GetReportedPostsService` is a class that provides methods to fetch reported posts.
///
/// It uses the Dio package to make HTTP requests.
class GetReportedPostsService {
  /// The URL for the API endpoint.
  final String url = '$apiUrl/dashboard/posts';

  /// Access token for authentication. Retrieved from the UserSingleton.
  final String token = UserSingleton().accessToken!;

  /// Dio instance for making HTTP requests.
  final Dio _dio = Dio();

  /// Fetches reported posts.
  ///
  /// Sends a GET request to the specified URL.
  ///
  /// Returns a `Future<Map<String, dynamic>>` which completes with a map containing the reported posts.
  ///
  /// Throws an exception if the request fails.

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

        List<List<Report>> reports = [];
        for (var post in postData) {
          List<dynamic>? reportData = post['reports'];
          if (reportData != null) {
            reports.add(
                reportData.map((report) => Report.fromJson(report)).toList());
          } else {
            reports.add([]);
          }
        }
        print(reports);
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
