import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

String apibase = apiUrl;

Future <List> getCommunitiesList() async {
  try {
    var response = await Dio().get('$apiUrl/community/random-category');
    if(response.statusCode == 200) {
      print(response.statusMessage);
      print(response.statusCode);
      print(response.data as List);
      return response.data as List;
    }
    else {
      print(response.statusMessage);
      print(response.statusCode);
      return [];
    }  
  }
  on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
      } 
      else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
      }
      return [];
    }
    rethrow;
  } 
  catch (e) {
    print("Error occurred: $e");
    return [];
  }

}
