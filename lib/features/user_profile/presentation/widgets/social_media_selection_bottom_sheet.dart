import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'social_media_button.dart';

/// A bottom sheet widget for selecting social media platforms.
class SocialMediaSelectionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Social Media Platform'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 5.0,
                runSpacing: 5.0,
                children: [
                  // Generate social media buttons for various platforms
                  SocialMediaButton(
                    icon: Icons.facebook,
                    text: 'Facebook',
                    iconColor: Colors.blue,
                    handleSelection: () => _handleSelection(context, 'Facebook', Icons.facebook, Colors.blue),
                  ),
                  // Add more SocialMediaButton widgets for other platforms
                  // ...
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles the selection of a social media platform.
  ///
  /// When a social media button is pressed, this function is called to
  /// pop the bottom sheet and return the selected platform's information
  /// to the caller.
  void _handleSelection(BuildContext context, String platform, IconData icon, Color color) {
    Navigator.pop(context, {
      'platformName': platform,
      'icon': icon,
      'color': color,
    });
  }
}
