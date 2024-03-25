import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:time_machine/time_machine.dart';

/// This function takes a [DateTime] as parameter and returns how
/// long ago (seconds/days/weeks/etc...) this date took place.
/// The returned variable is a formatted, read-to-display string,
/// suitable for the post card duration label in the [PostWidget] card
/// (e.g., 1 year ago is returned as "1y")
///
String dateToDuration(DateTime date) {
  final currentDate = LocalDateTime.dateTime(DateTime.now());
  final duration = currentDate.periodSince(LocalDateTime.dateTime(date));
  String formattedDuration;
  int years = duration.years;

  if (years > 0) {
    formattedDuration = '${years}y';
    return formattedDuration;
  }

  int months = duration.months;
  if (months > 0) {
    formattedDuration = '${months}mo.';
    return formattedDuration;
  }

  int days = duration.days;
  if (days > 0) {
    formattedDuration = '${days}d';
    return formattedDuration;
  }

  int hours = duration.hours;
  if (hours > 0) {
    formattedDuration = '${hours}h';
    return formattedDuration;
  }

  int minutes = duration.minutes;
  if (minutes > 0) {
    formattedDuration = '${minutes}m';
    return formattedDuration;
  }

  int seconds = duration.seconds;
  formattedDuration = '${seconds}s';
  return formattedDuration;
}
