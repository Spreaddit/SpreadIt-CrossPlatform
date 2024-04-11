import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/block_reported_user.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/main_report_option.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/main_report_section.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/modal_bottom_bar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('ReportModal widget test', (WidgetTester tester) async {
    
    await tester.pumpWidget(MaterialApp(
      home: CommunityPage(communityName: 'test_community'),
    ));

    await tester.pumpAndSettle();

    // Verify that the ElevatedButton is rendered
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the ElevatedButton to trigger ReportModal
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    // Verify that the MainReportSection is rendered
    expect(find.byType(MainReportSection), findsOneWidget);

    // Verify that the ModalBottomBar is rendered
    expect(find.byType(ModalBottomBar), findsOneWidget);

    // Verify that the BlockReportedUser is not rendered initially
    expect(find.byType(BlockReportedUser), findsNothing);

    // Verify that the Snackbar is not rendered initially
    expect(find.byType(CustomSnackbar), findsNothing);
  });

  testWidgets('MainReportOption color change test', (WidgetTester tester) async {
    // Build the widget with MainReportOption widgets
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            MainReportOption(
              communityName: 'Test Community',
              optionText: 'Option Text 1',
              index: 0,
              selectedContainerIndex: 1, // Not selected initially
              onSelect: () {},
              optionHasImage: false,
            ),
            MainReportOption(
              communityName: 'Test Community',
              optionText: 'Option Text 2',
              index: 1,
              selectedContainerIndex: 1, // Not selected initially
              onSelect: () {},
              optionHasImage: false,
            ),
          ],
        ),
      ),
    ));

    // Find the first container
    final firstContainerFinder = find.byType(Container).at(0);

    // Verify that the first container has the expected color
    BoxDecoration firstDecoration = tester.widget<Container>(firstContainerFinder).decoration as BoxDecoration;
    expect(firstDecoration.color, equals(Color.fromARGB(255, 240, 238, 238)));

    // Find the second container
    final secondContainerFinder = find.byType(Container).at(1);

    // Verify that the second container has the expected color
    BoxDecoration secondDecoration = tester.widget<Container>(secondContainerFinder).decoration as BoxDecoration;
    expect(secondDecoration.color, equals(Colors.blueAccent));
  });

  testWidgets('ModalBottomBar disabled button test', (WidgetTester tester) async {
    // Build the ModalBottomBar widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ModalBottomBar(
          buttonText: 'Button',
          onPressed: null,
          extraTextTitle: 'Extra Text',
          extraText: 'Extra description',
        ),
      ),
    ));

    // Find the ElevatedButton
    final buttonFinder = find.byType(ElevatedButton);

    // Verify that the button is disabled
    expect(tester.widget<ElevatedButton>(buttonFinder).enabled, isFalse);
  });
}
