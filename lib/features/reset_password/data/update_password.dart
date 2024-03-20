import 'package:dio/dio.dart';


void UpdatePassword(String currentPassword, String newPassword)async{
  try{
    final response = await Dio().post(
      "http://10.0.2.2:3001/AMIRAELGARF02/Spreadit1/1.0.0/reset-password",
       data: {'currentPassword': currentPassword, 'newPassword': newPassword}
       );
    if (response.statusCode == 200) {
      print(response.statusMessage);
    } 
    else {
      print(response.statusCode);
    }   
  }
  catch(e){
    print(e);
  }

}