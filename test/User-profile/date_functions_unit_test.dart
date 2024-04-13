import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/user_profile/data/date_conversion.dart';

void main() {
  group('formatDate', () {
    test('formats ISO date string correctly', () {
      String isoDateString = '2024-04-13T12:00:00Z';
      String expectedFormattedDate = 'Apr 13, 2024';
      String formattedDate = formatDate(isoDateString);
      expect(formattedDate, expectedFormattedDate);
    });
 test('formats past date correctly', () {
      // Past date: January 1, 2000
      String isoDateString = '2000-01-01T12:00:00Z';
      String expectedFormattedDate = 'Jan 1, 2000';

      String formattedDate = formatDate(isoDateString);

      expect(formattedDate, expectedFormattedDate);
    });
    test('formats future date correctly', () {
      // Future date: November 11, 2025
      String isoDateString = '2025-11-11T12:00:00Z';
      String expectedFormattedDate = 'Nov 11, 2025';

      String formattedDate = formatDate(isoDateString);

      expect(formattedDate, expectedFormattedDate);
    });
    test('formats edge case date correctly', () {
      // Edge case: February 29, 2024 (leap year)
      String isoDateString = '2024-02-29T12:00:00Z';
      String expectedFormattedDate = 'Feb 29, 2024';

      String formattedDate = formatDate(isoDateString);

      expect(formattedDate, expectedFormattedDate);
    });


  });
}
