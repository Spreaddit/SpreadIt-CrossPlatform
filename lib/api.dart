import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiURL() {
  return "http://localhost:3002/FAROUQDIAAELDIN/SpreadIt/1.0.0/"; //WEB
  // return "http://10.0.2.2:3002/FAROUQDIAAELDIN/SpreadIt/1.0.0/"; //MOBILE
  if (dotenv.env['API_URL'] != null) {
    return dotenv.env['API_URL'] ?? "";
  } else {
    throw Exception('Error connecting to api');
  }
}
