import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// The `PlatformIconMapper` class provides static methods to retrieve icon data and colors for various social media platforms.
///
/// This class is useful for displaying platform-specific icons and colors within the user interface.
class PlatformIconMapper {
  /// Returns the icon data for a given platform name.
  ///
  /// Parameters:
  /// - `platformName`: The name of the platform.
  ///
  /// Returns:
  /// - The icon data corresponding to the platform name. If the platform name is not recognized, returns the default link outline icon.
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

  /// Returns the color for a given platform name.
  ///
  /// Parameters:
  /// - `platformName`: The name of the platform.
  ///
  /// Returns:
  /// - The color corresponding to the platform name. If the platform name is not recognized, returns the default grey color.
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
