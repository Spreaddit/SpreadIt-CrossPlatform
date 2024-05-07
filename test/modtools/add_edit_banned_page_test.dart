import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_edit_banned_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/add_data_appbar.dart';

void main() {
  testWidgets('AddOrEditBannedPage widget test', (WidgetTester tester) async {
    // Build the AddOrEditBannedPage widget
    await tester.pumpWidget(MaterialApp(
      home: AddOrEditBannedPage(
        communityName: 'test_community',
        isAdding: true,
        onRequestCompleted: () {}, // Mock onRequestCompleted function
      ),
    ));

    // Verify that the necessary widgets exist
    expect(find.text('Username'), findsAny);
    expect(find.text('Reason for ban'), findsOneWidget);
    expect(find.text('Mod note'), findsOneWidget);
    expect(find.text('How Long?'), findsOneWidget);
    expect(find.text('Note to be included in ban message'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(5)); // Five text fields
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(AddOrSaveDataAppBar), findsOneWidget);

  });
}
