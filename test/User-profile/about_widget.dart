import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/about.dart';
import 'package:flutter/cupertino.dart';
void main() {
  testWidgets('AboutWidget displays correctly for other users profile', (WidgetTester tester) async {
    // Build AboutWidget
    await tester.pumpWidget(MaterialApp(
      home: AboutWidget(
        postKarmaNo: '100',
        commentKarmaNo: '50',
        aboutText: 'Sample about text',
        myProfile: true,
      ),
    ));

    // Verify that the text widgets display the correct content
    expect(find.text('100'), findsOneWidget); // Post Karma
    expect(find.text('50'), findsOneWidget);  // Comment Karma
    expect(find.text('Sample about text'), findsOneWidget);

    // Verify that send message and start chat buttons are not visible
    expect(find.byIcon(CupertinoIcons.envelope), findsNothing);
    expect(find.byIcon(CupertinoIcons.chat_bubble_2_fill), findsNothing);
  });

  testWidgets('AboutWidget displays correctly for my profile', (WidgetTester tester) async {
    // Build AboutWidget with callback functions for sending message and starting chat
    await tester.pumpWidget(MaterialApp(
      home: AboutWidget(
        postKarmaNo: '100',
        commentKarmaNo: '50',
        aboutText: 'Sample about text',
        myProfile: false,
        onSendMessagePressed: () {},
        onStartChatPressed: () {},
      ),
    ));

    // Verify that send message and start chat buttons are visible
    expect(find.byIcon(CupertinoIcons.envelope), findsOne);
    expect(find.byIcon(CupertinoIcons.chat_bubble_2_fill), findsOne);
  });


}
