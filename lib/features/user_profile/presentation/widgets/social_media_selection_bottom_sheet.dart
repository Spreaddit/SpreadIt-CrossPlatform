import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
        child: Container(
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
                    iconColor: Colors.blue,
                    handleSelection: () => _handleSelection(context, 'Facebook', Icons.facebook, Colors.blue),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_instagram,
                    text: 'Instagram',
                    iconColor: Colors.redAccent,
                    handleSelection: () => _handleSelection(context, 'Instagram', Ionicons.logo_instagram, Colors.redAccent),
                  ),
                  SocialMediaButton(
                    icon: Icons.snapchat,
                    text: 'Snapchat',
                    iconColor: Colors.yellow,
                    handleSelection: () => _handleSelection(context, 'Snapchat', Icons.snapchat, Colors.yellow),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_linkedin,
                    text: 'linkedin',
                    iconColor: Colors.blue,
                    handleSelection: () => _handleSelection(context, 'linkedin', Ionicons.logo_linkedin, Colors.blue),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_paypal,
                    text: 'PayPal',
                    iconColor: Colors.blue,
                    handleSelection: () => _handleSelection(context, 'PayPal', Ionicons.logo_paypal, Colors.blue),
                  ),
                  SocialMediaButton(
                    icon:  Ionicons.logo_github,
                    text: 'Github',
                    iconColor: Colors.black,
                    handleSelection: () => _handleSelection(context, 'Github',Ionicons.logo_github, Colors.black),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_soundcloud,
                    text: 'SoundCloud',
                    iconColor: Colors.orange,
                    handleSelection: () => _handleSelection(context, 'SoundCloud', Ionicons.logo_soundcloud, Colors.orange),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_twitch,
                    text: 'Twitch',
                    iconColor: Colors.purple,
                    handleSelection: () => _handleSelection(context, 'Twitch', Ionicons.logo_twitch, Colors.purple),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_twitter,
                    text: 'Twitter',
                    iconColor: Colors.lightBlue,
                    handleSelection: () => _handleSelection(context, 'Twitter', Ionicons.logo_twitter, Colors.lightBlue),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_venmo,
                    text: 'Venmo',
                    iconColor: Colors.blueAccent,
                    handleSelection: () => _handleSelection(context, 'Venmo', Ionicons.logo_venmo, Colors.blueAccent),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.logo_tiktok,
                    text: 'TikTok',
                    iconColor: Colors.black,
                    handleSelection: () => _handleSelection(context, 'TikTok', Ionicons.logo_tiktok, Colors.black),
                  ),
                  SocialMediaButton(
                    icon: Ionicons.link_outline,
                    text: 'Custom',
                    iconColor: Colors.grey,
                    handleSelection: () => _handleSelection(context, 'Custom', Ionicons.link_outline, Colors.grey),
                  ),
                ],
              ),
            ],
          ),
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
