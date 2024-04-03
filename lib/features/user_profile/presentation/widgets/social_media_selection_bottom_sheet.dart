import 'package:flutter/material.dart';

import 'social_link_bottom_sheet_model.dart';
import 'social_media_button.dart';

class SocialMediaSelectionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Social Media Platform'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 5.0,
              runSpacing: 5.0,
              children: [
                SocialMediaButton(
                  icon: Icons.facebook,
                  text: 'Facebook',
                  backgroundColor: Colors.blue,
                  handleSelection: () => _handleSelection(context, 'Facebook', Icons.facebook, Colors.blue),
                ),
                SocialMediaButton(
                  icon: Icons.snapchat,
                  text: 'Snapchat',
                  backgroundColor: Colors.yellow,
                  handleSelection: () => _handleSelection(context, 'Snapchat', Icons.snapchat, Colors.yellow),
                ),
                SocialMediaButton(
                  icon: Icons.reddit,
                  text: 'Reddit',
                  backgroundColor: Colors.red,
                  handleSelection: () => _handleSelection(context, 'Reddit', Icons.reddit, Colors.red),
                ),
                SocialMediaButton(
                  icon: Icons.discord,
                  text: 'Discord',
                  backgroundColor: Colors.purple,
                  handleSelection: () => _handleSelection(context, 'Discord', Icons.discord, Colors.purple),
                ),
                SocialMediaButton(
                  icon: Icons.play_circle_fill,
                  text: 'YouTube',
                  backgroundColor: Colors.red,
                  handleSelection: () => _handleSelection(context, 'YouTube', Icons.play_circle_fill, Colors.red),
                ),
                SocialMediaButton(
                  icon: Icons.phone_in_talk,
                  text: 'Skype',
                  backgroundColor: Colors.lightBlue,
                  handleSelection: () => _handleSelection(context, 'Skype', Icons.phone_in_talk, Colors.lightBlue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleSelection(BuildContext context, String platform, IconData icon, Color color) {
    
      Navigator.pop(context, {
                'platformName': platform,
                'icon': icon,
                'color': color,
              });
  }
}
