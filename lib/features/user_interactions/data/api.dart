import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiURL() {
  if (dotenv.env['API_URL'] != null) {
    return dotenv.env['API_URL'] ?? "";
  } else {
    throw Exception('Error connecting to api');
  }
}