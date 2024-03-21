import 'package:dio/dio.dart';

const apibase= "http://10.0.2.2:3002/M7MDREFAAT550/Spreadit/2.0.0";

Future<int> GoogleOuthApi(
    {required String googleToken,
    }) async {
  try {
    const apiroute= "/google/oauth";
    const apiURl= apibase + apiroute; 
    var data = {
    "googleToken": googleToken,
    }; 
     final response = await Dio().post(apiURl, data: data);
    if (response.statusCode == 200) {
      var token = response.data['access_token'];     /// save the access token 
      var user = response.data['user'];              // save the user data
      var acesstokenexpiry= response.data['token_expiration_date']; // save the user data
      print("token: $token");
      print(response.statusMessage);
      return 200;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
      return 409;
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
      return 400;
    }  else if (response.statusCode == 500) {
      print("Server error: ${response.statusMessage}");
      return 500;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
        return 400;
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
        return 409;
      }
      else if (e.response!.statusCode == 500) {
        print("Conflict: ${e.response!.statusMessage}");
        return 500;
      }
    }
    print("Dio error occurred: $e");
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}