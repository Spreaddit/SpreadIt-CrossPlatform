import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiURL() {
  return "http://localhost:3002/FAROUQDIAAELDIN/SpreadIt/1.0.0/";
  if (dotenv.env['API_URL'] != null) {
    return dotenv.env['API_URL'] ?? "";
  } else {
    throw Exception('Error connecting to api');
  }
}
