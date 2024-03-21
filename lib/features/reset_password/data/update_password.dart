import 'package:dio/dio.dart';


Future <bool> UpdatePassword(String newPassword, String currentPassword)async{
  try{
    final response = await Dio().post(
      "http://10.0.2.2:3000/M7MDREFAAT550/Spreadit/2.0.0/reset-password",
       data: {
        "newPassword": newPassword,
        "currentPassword": currentPassword}
       );
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