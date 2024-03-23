import 'package:dio/dio.dart';

import 'package:dio/dio.dart';

const apiBase = "http://10.0.2.2:3000/M7MDREFAAT550/Spreadit/2.0.0";

Future <int> sendUserInput(String usernameOrEmail) async{
  try{
    const apiRoute = "/app/forgot-password";
    const apiURL = apiBase + apiRoute ;
    final response = await Dio().post(
       apiURL,
       data: {
        "usernameOremail": usernameOrEmail
        }  
       );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.statusMessage);
      return 200;
    } 
    else if (response.statusCode == 400) {
      print(response.statusMessage);
      print (response.statusCode);
      return 400;
    }
    else if (response.statusCode == 500) {
      print(response.statusMessage);
      print (response.statusCode);
      return 500;
    }
    else {
      print(response.statusMessage);
      print (response.statusCode);
      return 404;
    }

  }
  on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print(e.response!.statusMessage);
        return 400;
      } 
      else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return 500;
      }
    }
    rethrow;
  }
  catch (e) {
    print("Error occurred: $e");
    return 404;
  }

}