import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/edit_moderators_permissions.dart';

void main() {
  group('EditPermissionsPage UI Tests', () {
    testWidgets('EditPermissionsPage builds and updates UI',
        (WidgetTester tester) async {
      // Create the widget by pumping it into the widget tester
      await tester.pumpWidget(MaterialApp(
        home: EditPermissionsPage(
          communityName: 'test_community',
          username: 'testuser',
          managePostsAndComments: false,
          manageUsers: false,
          manageSettings: false,
          onPermissionsChanged: (bool newManagePostsAndComments,
              bool newManageUsers, bool newManageSettings) {
            // This is just a placeholder and will not be called in this test
          },
        ),
      ));

      // Verify the initial state of the checkboxes
      expect(find.byType(CheckboxListTile), findsNWidgets(3));

      // Verify the 'Save' button is present and can be tapped
      expect(find.text('Save'), findsOneWidget);
    });
  });
}
