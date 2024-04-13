// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/image_and_video_widgets.dart';
// import '../../lib/features/create_post/presentation/pages/final_content_page.dart';

// void main() {
//   // testWidgets('CreatePost page widgets test', (WidgetTester tester) async {
//   //   await tester.pumpWidget(MaterialApp(
//   //      home: Scaffold(
//   //       body: FinalCreatePost(
//   //         title: '',
//   //         content: '',
//   //         community: [
//   //           {
//   //             'communityName': 'r/AskReddit', 
//   //             'communityIcon': './assets/images/LogoSpreadIt.png',
//   //             'communityRules' : [
//   //               {
//   //               'title': 'hate is not tolerated',
//   //               'description': 'yarab nekhlas baa ana zhe2t men om el bta3 da',
//   //               },
//   //               {
//   //               'title': '3ayza a3ayyat',
//   //               'description': 'kefaya 3alayy akeda abous ideiko',
//   //               }
//   //            ],
//   //         }]
//   //       ),)
//   //   ));

//     //check if the header is present
//     expect(find.text('Post'), findsOneWidget);
//     expect(find.byIcon(Icons.clear_rounded), findsOneWidget);

//     //check if the community info is present
//     expect(find.text('r/AskReddit'), findsOneWidget);
//     expect(find.byType(CircleAvatar), findsOneWidget);

//     //check if add tags button is present
//     expect(find.widgetWithText(ElevatedButton, 'Add tags'), findsOneWidget);
//     expect(find.text('Rules'), findsOneWidget);

//     //Check if the title field and content textfield are present 
//     expect(find.widgetWithText(TextField, 'Title'), findsOneWidget);
//     expect(find.widgetWithText(TextField, 'body text (optional)'), findsOneWidget);

//     //Check if the footer is present
//     expect(find.byIcon(Icons.link), findsOneWidget);
//     expect(find.byIcon(Icons.photo), findsOneWidget);
//     expect(find.byIcon(Icons.ondemand_video_rounded), findsOneWidget);
//     expect(find.byIcon(Icons.poll), findsOneWidget);
//     expect(find.byIcon(Icons.keyboard_arrow_down), findsExactly(2));

//     //check that the link icon works
//     await tester.tap(find.byIcon(Icons.link));
//     await tester.pump();
//     expect(find.widgetWithText(TextField, 'URL'), findsOneWidget);

//     //test the functionality of add tags button
//     await tester.tap(find.text('Add tags'));
//     await tester.pump();
//     expect(find.text('Spoiler'), findsOneWidget);
//     expect(find.text('NSFW'), findsOneWidget);
//     expect(find.byType(Switch), findsExactly(2));
//     // check that the photo icon works
//    /* await tester.tap(find.byIcon(Icons.photo));
//     await tester.pump();
//     expect(find.byType (ImageOrVideoWidget), findsOneWidget);

//     // check that the video icon works
//     await tester.tap(find.byIcon(Icons.photo));
//     await tester.pump();
//     expect(find.byType (ImageOrVideoWidget), findsOneWidget);*/

//     // check that the poll icon works 
//     /*await tester.tap(find.byIcon(Icons.poll));
//     await tester.pump();
//     expect(find.text('Add option'), findsOneWidget);*/
//     /*expect(find.widgetWithText(TextField, 'Option 1'), findsOneWidget);
//     expect(find.widgetWithText(TextField, 'Option 2'), findsOneWidget);
//     expect(find.byType(InkWell), findsOneWidget);
//     expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);*/





    
    
//   });
// }
