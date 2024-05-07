import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

/// Base URL for the API.
String apibase = apiUrl;

/// Checks the availability of a username.
///
/// Makes a request to the server to check if the provided username is available or not.
///
/// [username] is the username to check.
/// [checkIfAvaliable] is a flag indicating whether to check if the username is available or not.
///
/// Returns a [Future] that resolves to a boolean value indicating whether the username is available.
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
      return response.data['available'] == true;    // true if available, false if taken
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
