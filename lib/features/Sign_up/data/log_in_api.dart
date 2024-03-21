import 'package:dio/dio.dart';

const apibase= "http://10.0.2.2:3002/M7MDREFAAT550/Spreadit/2.0.0";

Future<int> logInApi(
    {required String username,
    required String password,
    }) async {
  try {
    const apiroute= "/login";
    const apiURl= apibase + apiroute; 
    var data = {
    "username": username,
    "password": password
    }; 
     final response = await Dio().post(apiURl, data: data);

    if (response.statusCode == 200) {
      var token = response.data['access_token'];     // save the access token 
      var user = response.data['user'];              // save the user data
      var acesstokenexpiry= response.data['token_expiration_date']; // save the user data
      
      print("acesstokenexpiry: $acesstokenexpiry");
      print("user: $user");
      print("token: $token");
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 404) {
      print("Not Found: ${response.statusMessage}");
      return 404;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    }  
    else if (response.statusCode == 401) {
      print("Unauthorized ${response.statusMessage}");
      return 401;
    }  
    else {
      print("Unexpected status code: ${response.statusCode}");
      return 409;
    } 

  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 401) {
        print("Unauthorized ${e.response!.statusMessage}");
        return 401;
      }
       else if (e.response!.statusCode == 404) {
        print("Not Found: ${e.response!.statusMessage}");
        return 404;
      }
    }
    print("Dio error occurred: $e");
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 409;
  }
}