import 'package:dio/dio.dart';

Future<bool> sendUserInput(String usernameOrEmail) async{
  try{
    print(usernameOrEmail);
    final response = await Dio().post(
      "http://10.0.2.2:3000/M7MDREFAAT550/Spreadit/2.0.0/forgot-password",
      data: {"email": usernameOrEmail});
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return true;
    } 
    else {
      print(response.statusCode);
      return false;
    }
  }
  catch(e){
    print(e);
    return false;
  }
}