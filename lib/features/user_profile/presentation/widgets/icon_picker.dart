import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PlatformIconMapper {
  static IconData getIconData(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Ionicons.logo_instagram;
      case 'snapchat':
        return Icons.snapchat;
      case 'linkedin':
        return Ionicons.logo_linkedin;
      case 'paypal':
        return Ionicons.logo_paypal;
      case 'github':
        return Ionicons.logo_github;
      case 'soundcloud':
        return Ionicons.logo_soundcloud;
      case 'twitch':
        return Ionicons.logo_twitch;
      case 'twitter':
        return Ionicons.logo_twitter;
      case 'venmo':
        return Ionicons.logo_venmo;
      case 'tiktok':
        return Ionicons.logo_tiktok;
      default:
        return Ionicons.link_outline; // Default icon for custom platforms
    }
  }

  static Color getColor(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'facebook':
        return Colors.blue;
      case 'instagram':
        return Colors.redAccent;
      case 'snapchat':
        return Colors.yellow;
      case 'linkedin':
        return Colors.blue;
      case 'paypal':
        return Colors.blue;
      case 'github':
        return Colors.black;
      case 'soundcloud':
        return Colors.orange;
      case 'twitch':
        return Colors.purple;
      case 'twitter':
        return Colors.lightBlue;
      case 'venmo':
        return Colors.blueAccent;
      case 'tiktok':
        return Colors.black;
      default:
        return Colors.grey; // Default color for custom platforms
    }
  }
}
