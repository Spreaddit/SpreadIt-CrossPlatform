import 'package:intl/intl.dart'; 

/// Formats an ISO-formatted date string into a formatted date string.
///
/// This function takes an ISO-formatted date string and converts it into a
/// formatted date string in the "MMM d, yyyy" format.
///
/// Parameters:
///   - isoDateString: The ISO-formatted date string to be formatted.
///
/// Returns:
///   A formatted date string in the "MMM d, yyyy" format.
String formatDate(String isoDateString) {
  // Parsing the ISO-formatted date string into a DateTime object.
  DateTime dateTime = DateTime.parse(isoDateString);
  // Formatting the DateTime object into a formatted date string.
  String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
  return formattedDate;
}
