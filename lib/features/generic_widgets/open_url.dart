import 'package:url_launcher/url_launcher.dart';

/// Launches a URL.
///
/// Takes a [link] parameter, which is the URL to launch.
///
/// Example:
/// ```dart
/// launchURL('https://example.com');
/// ```
void launchURL(String link) async {
  final Uri url = Uri.parse(link);
   if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
    throw 'Could not launch $url';
  }
}
