import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

String apibase = apiUrl;

Future<bool> checkUsernameAvailability({
  required String username,
  required bool checkIfAvaliable, 
}) async {
  try {
    const apiroute = "/check-username";
    String apiUrl = apibase + apiroute;
    var data = {
      "username": username,
    };
    final response = await Dio().post(apiUrl, data: data);
    if (response.statusCode == 200) {
      return response.data['available'] == true;    // avaliable true taken false
    } else {
      print("Request failed with status: ${response.statusCode}");
      return checkIfAvaliable ? false : true ;
    }
  } on DioException catch (e) {
    print("Dio error occurred: $e");
    return checkIfAvaliable ? false : true ;
  } catch (e) {
    print("Error occurred: $e");
      return checkIfAvaliable ? false : true ;
  }
}
