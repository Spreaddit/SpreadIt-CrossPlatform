import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../data/report_data_model.dart';

class GetReportedCommentsService {
  final String url =
      '$apiUrl/dashboard/comments'; // Change this to the correct endpoint
  final String token =
      UserSingleton().accessToken!; // replace with actual token
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getReportedComments() async {
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
        List<dynamic> commentData = response.data['reportedComments'];
        List<Comment> comments =
            commentData.map((comment) => Comment.fromJson(comment)).toList();

        print(commentData);
        List<List<Report>> reports = [];
        for (var comment in commentData) {
          List<dynamic>? reportData = comment['reports'];
          if (reportData != null) {
            reports.add(
                reportData.map((report) => Report.fromJson(report)).toList());
          } else {
            reports.add([]);
          }
        }
        print(reports);
        return {
          'comments': comments,
          'reports': reports,
        };
      } else {
        throw Exception(
            'Failed to load reported comments: status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load reported comments: $e');
    }
  }
}
