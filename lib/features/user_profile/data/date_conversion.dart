
import 'package:intl/intl.dart';

String formatDate(String isoDateString) {
  DateTime dateTime = DateTime.parse(isoDateString);
  String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
  return formattedDate;
}

