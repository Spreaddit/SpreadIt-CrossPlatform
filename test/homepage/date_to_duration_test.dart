import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';

void main() {
  group('Years', () {
    test('dateToDuration returns correct duration string for 1 year ago', () {
      expect(
          dateToDuration(DateTime.now().subtract(Duration(days: 400))), '1y');
    });
  });

  group('Months', () {
    test('dateToDuration returns correct duration string for 1 month ago', () {
      expect(
          dateToDuration(DateTime.now().subtract(Duration(days: 35))), '1mo.');
    });
  });

  group('Days', () {
    test('dateToDuration returns correct duration string for 1 day ago', () {
      expect(dateToDuration(DateTime.now().subtract(Duration(days: 1))), '1d');
    });
  });

  group('Hours', () {
    test('dateToDuration returns correct duration string for 1 hour ago', () {
      expect(dateToDuration(DateTime.now().subtract(Duration(hours: 1))), '1h');
    });
  });

  group('Minutes', () {
    test('dateToDuration returns correct duration string for 1 minute ago', () {
      expect(
          dateToDuration(DateTime.now().subtract(Duration(minutes: 1))), '1m');
    });
  });

  group('Seconds', () {
    test('dateToDuration returns correct duration string for 1 second ago', () {
      expect(
          dateToDuration(DateTime.now().subtract(Duration(seconds: 1))), '1s');
    });
  });
}
