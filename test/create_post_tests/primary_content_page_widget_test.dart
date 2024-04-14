import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/image_and_video_widgets.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/poll_widgets/poll.dart';
import '../../lib/features/create_post/presentation/pages/primary_content_page.dart';

void main() {
  testWidgets('CreatePost page widgets test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
       home: Scaffold(
        body: CreatePost(),)
    ));

    //check if the header is present
    expect(find.text('Next'), findsOneWidget);
    expect(find.byIcon(Icons.clear_rounded), findsOneWidget);
    
    //Check if the title field and content textfield are present  
    expect(find.widgetWithText(TextField, 'Title'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'body text (optional)'), findsOneWidget);

    //Check if the footer is present
    expect(find.byIcon(Icons.link), findsOneWidget);
    expect(find.byIcon(Icons.photo), findsOneWidget);
    expect(find.byIcon(Icons.ondemand_video_rounded), findsOneWidget);
    expect(find.byIcon(Icons.poll), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);

    //check that the link icon works
    await tester.tap(find.byIcon(Icons.link));
    await tester.pump();
    expect(find.widgetWithText(TextField, 'URL'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.cancel));
    await tester.pump();
    expect(find.widgetWithText(TextField, 'URL'),findsNothing);

    // check that the poll icon works 
    await tester.tap(find.byIcon(Icons.poll));
    await tester.pump();
    expect(find.widgetWithText(TextField, 'Option 1'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Option 2'), findsOneWidget);
    expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);

    // check that the cancel poll icon works
    await tester.tap(find.byIcon(Icons.cancel_rounded));
    await tester.pump();
    expect(find.widgetWithText(TextField, 'Option 1'), findsNothing);
    expect(find.widgetWithText(TextField, 'Option 2'), findsNothing);





    
    
  });
}
