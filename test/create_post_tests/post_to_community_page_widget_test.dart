import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/create_post/data/get_communities_list.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/post_to_community_page.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/widgets/image_and_video_widgets.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/search_bar.dart';
import '../../lib/features/create_post/presentation/pages/primary_content_page.dart';

void main() {
  testWidgets('CreatePost page widgets test', (WidgetTester tester) async {
    // Mocking the getCommunitiesList function
    final mockGetCommunitiesList = getCommunitiesList();

    // Stubbing the behavior of getCommunitiesList to return an empty list
    when(mockGetCommunitiesList).thenAnswer((_) async => []);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PostToCommunity(
          title: '',
          content: '',
          isLinkAdded: false,
          selectedDay: 1,
          createPoll: false,
          pollOptions: [],
        ),
      ),
    ));

    // Verify that the 'Post to' text is found on the screen
    expect(find.text('Post to'), findsOneWidget);
  });
}