import 'package:dio/dio.dart';

import 'package:dio/dio.dart';

const apiBase = "http://localhost:3000/M7MDREFAAT550/Spreadit/2.0.0";

Future<int> sendEmail(String email) async {
  try {
    const apiRoute = "/forgot-username";
    const apiURL = apiBase + apiRoute;
    final response = await Dio().post(apiURL, data: {"email": email});
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 500) {
      print(response.statusMessage);
      print(response.statusCode);
      return 500;
    } else {
      print(response.statusMessage);
      print(response.statusCode);
      return 404;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return 500;
      }
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
