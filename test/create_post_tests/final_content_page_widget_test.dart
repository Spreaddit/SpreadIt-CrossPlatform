 import 'package:flutter/material.dart';
 import 'package:flutter_test/flutter_test.dart';
 import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/image_and_video_widgets.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
 import '../../lib/features/create_post/presentation/pages/final_content_page.dart';

 void main() {
    testWidgets('CreatePost page widgets test', (WidgetTester tester) async {
     await tester.pumpWidget(MaterialApp(
      home: Scaffold(
       body: FinalCreatePost(
         title: '',
         content: '',
         pollOptions: [], 
         selectedDay: 1,
         isLinkAdded: false, 
         createPoll: false,
         community: [
          Community(
            name: 'r/AskReddit',
            description: 'A community where you can ask about anything',
            image: './assets/images/LogoSpreadIt.png',
            membersCount: 5,
            rules: [
              Rule(
              id:'0',
              title: 'Rule 1',
              description: 'Description 1',
              reportReason: '',
              communityName: 'r/AskReddit'
            ),
              Rule(
                id: '1',
                title: 'Rule 2', 
                description: 'Description 2',
                reportReason: '',
                communityName: 'r/AskReddit'
              ),
            ]
            ),  
         ],
       ),
      ),
     ),
     );

  //check if the header is present
  expect(find.text('Post'), findsOneWidget);
  expect(find.byIcon(Icons.clear_rounded), findsOneWidget);

  //check if the community info is present
  expect(find.text('r/AskReddit'), findsOneWidget);
  expect(find.byType(CircleAvatar), findsOneWidget);

  //check if add tags button is present
  expect(find.widgetWithText(ElevatedButton, 'Add tags'), findsOneWidget);
  expect(find.text('Rules'), findsOneWidget);

  //Check if the title field and content textfield are present 
  expect(find.widgetWithText(TextField, 'Title'), findsOneWidget);
  expect(find.widgetWithText(TextField, 'body text (optional)'), findsOneWidget);

  //Check if the footer is present
  expect(find.byIcon(Icons.link), findsOneWidget);
  expect(find.byIcon(Icons.photo), findsOneWidget);
  expect(find.byIcon(Icons.ondemand_video_rounded), findsOneWidget);
  expect(find.byIcon(Icons.poll), findsOneWidget);
  expect(find.byIcon(Icons.keyboard_arrow_down), findsExactly(3));


  //test the functionality of add tags button
  await tester.tap(find.text('Add tags'));
  await tester.pump();
  expect(find.text('Spoiler'), findsOneWidget);
  expect(find.text('NSFW'), findsOneWidget);
  expect(find.byType(Switch), findsExactly(2));


  
   });
 }
