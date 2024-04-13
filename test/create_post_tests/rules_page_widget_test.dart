// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:spreadit_crossplatform/features/create_post/presentation/pages/rules_page.dart';

// void main() {
//   testWidgets('CommunityRules widget test', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(
//       home: CommunityRules(
//         communityRules: [
//           {'title': 'Rule 1', 'description': 'Description 1'},
//           {'title': 'Rule 2', 'description': 'Description 2'},
//         ],
//       ),
//     ));

//     //check that the header is present 
//     expect(find.text('Community rules'), findsOneWidget);
//     expect(find.text('Rules are different for each community. Reviewing the rules can help you be more successful when posting or commenting on this community'), findsOneWidget);

//     //Verify if all the rules are displayed 
//     expect(find.text('Rule 1'), findsOneWidget);
//     expect(find.text('Rule 2'), findsOneWidget);

//     //Verify that the arrows work 
//     expect(find.byIcon(Icons.keyboard_arrow_down), findsExactly(2));
//     await tester.tap(find.text('Rule 1'));
//     await tester.pump();
//     expect(find.text('Description 1'), findsOneWidget);
    

//     //Verify that the "I understand" button works 
//     await tester.tap(find.text('I understand'));
//     await tester.pump();

//   });
// }
