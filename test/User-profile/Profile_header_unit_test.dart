import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/profile_header.dart';

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  testWidgets('ProfileHeader widget test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileHeader(
              backgroundImage: 'https://media.gettyimages.com/id/641697142/photo/landscape-of-cairo.jpg?s=612x612&w=gi&k=20&c=wDzngyj9rr5yyy6CP0HKbMHQh9S8mfvDaiHcJF8fwMU=',
              profilePicture: 'https://media.gettyimages.com/id/641697142/photo/landscape-of-cairo.jpg?s=612x612&w=gi&k=20&c=wDzngyj9rr5yyy6CP0HKbMHQh9S8mfvDaiHcJF8fwMU=',
              username: 'test_user',
              userinfo: 'Test User',
              about: 'About Test User',
              myProfile: true,
              followed: false,
              socialMediaLinks: [
                {'platform': 'twitter', 'displayName': 'Twitter', 'url': 'twitter_url'},
                {'platform': 'facebook', 'displayName': 'Facebook', 'url': 'facebook_url'},
              ],
            ),
          ),
        ),
      );

      // Find elements in the widget tree
      final usernameFinder = find.text('test_user');
      final userinfoFinder = find.text('Test User');
      final aboutFinder = find.text('About Test User');
      final twitterButtonFinder = find.byIcon(Ionicons.logo_twitter);
      final facebookButtonFinder = find.byIcon(Icons.facebook);

      expect(usernameFinder, findsOneWidget);
      expect(userinfoFinder, findsOneWidget);
      expect(aboutFinder, findsOneWidget);
      expect(twitterButtonFinder, findsOneWidget);
      expect(facebookButtonFinder, findsOneWidget);
    });
  });
}
