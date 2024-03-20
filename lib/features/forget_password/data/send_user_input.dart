import 'package:dio/dio.dart';

Future<bool> sendUserInput(String usernameOrEmail) async{
  try{
    final response = await Dio().post("http://10.0.2.2:3001/AMIRAELGARF02/Spreadit1/1.0.0/forgot-password", data: {"email": usernameOrEmail});
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