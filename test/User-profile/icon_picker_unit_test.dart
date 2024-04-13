import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/icon_picker.dart';

void main() {
  test('Test getIconData', () {
    expect(PlatformIconMapper.getIconData('facebook'), Icons.facebook);
    expect(PlatformIconMapper.getIconData('instagram'), Ionicons.logo_instagram);
    expect(PlatformIconMapper.getIconData('snapchat'), Icons.snapchat);
    expect(PlatformIconMapper.getIconData('linkedin'), Ionicons.logo_linkedin);
    expect(PlatformIconMapper.getIconData('paypal'), Ionicons.logo_paypal);
    expect(PlatformIconMapper.getIconData('github'), Ionicons.logo_github);
    expect(PlatformIconMapper.getIconData('soundcloud'), Ionicons.logo_soundcloud);
    expect(PlatformIconMapper.getIconData('twitch'), Ionicons.logo_twitch);
    expect(PlatformIconMapper.getIconData('twitter'), Ionicons.logo_twitter);
    expect(PlatformIconMapper.getIconData('venmo'), Ionicons.logo_venmo);
    expect(PlatformIconMapper.getIconData('tiktok'), Ionicons.logo_tiktok);
    expect(PlatformIconMapper.getIconData('unknown'), Ionicons.link_outline);
  });

  test('Test getColor', () {
    expect(PlatformIconMapper.getColor('facebook'), Colors.blue);
    expect(PlatformIconMapper.getColor('instagram'), Colors.redAccent);
    expect(PlatformIconMapper.getColor('snapchat'), Colors.yellow);
    expect(PlatformIconMapper.getColor('linkedin'), Colors.blue);
    expect(PlatformIconMapper.getColor('paypal'), Colors.blue);
    expect(PlatformIconMapper.getColor('github'), Colors.black);
    expect(PlatformIconMapper.getColor('soundcloud'), Colors.orange);
    expect(PlatformIconMapper.getColor('twitch'), Colors.purple);
    expect(PlatformIconMapper.getColor('twitter'), Colors.lightBlue);
    expect(PlatformIconMapper.getColor('venmo'), Colors.blueAccent);
    expect(PlatformIconMapper.getColor('tiktok'), Colors.black);
    expect(PlatformIconMapper.getColor('unknown'), Colors.grey);
  });
}
