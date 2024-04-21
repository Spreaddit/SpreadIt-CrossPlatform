import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/community_element.dart';

class CommunitiesPageView extends StatefulWidget {
  const CommunitiesPageView({Key? key}) : super(key: key);

  @override
  State<CommunitiesPageView> createState() => _CommunitiesPageViewState();
}

class _CommunitiesPageViewState extends State<CommunitiesPageView> {

  List communities = 
  [
    {
      'communityName': 'r/FlutterEnthusiasts',
      'communityDescription': 'A community for passionate Flutter developers to share knowledge and collaborate on projects.',
      'communityIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'communityName': 'r/DartWizards',
      'communityDescription': 'Join us to explore the magic of Dart programming language and its endless possibilities.',
      'communityIcon': './assets/images/GoogleLogo.png',
    },
    {
      'communityName': 'r/UI/UXDesignersHub',
      'communityDescription': 'Connect with fellow designers, share your creative ideas, and learn new design techniques.',
      'communityIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'communityName': 'r/AskReddit',
      'communityDescription': 'Just ask us about anything.',
      'communityIcon': './assets/images/GoogleLogo.png',
    },
    {
      'communityName': 'r/Artists',
      'communityDescription': 'A community for passionate artists where they can explore a whole new world.',
      'communityIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'communityName': 'r/FIHateSoftware',
      'communityDescription': 'Mayyetin abou el software 3ala mayyetin abou el project.',
      'communityIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'communityName': 'r/FlutterEnthusiasts',
      'communityDescription': 'A community for passionate Flutter developers to share knowledge and collaborate on projects.',
      'communityIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'communityName': 'r/DartWizards',
      'communityDescription': 'Join us to explore the magic of Dart programming language and its endless possibilities.',
      'communityIcon': './assets/images/GoogleLogo.png',
    },
    {
      'communityName': 'r/UI/UXDesignersHub',
      'communityDescription': 'Connect with fellow designers, share your creative ideas, and learn new design techniques.',
      'communityIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'communityName': 'r/AskReddit',
      'communityDescription': 'Just ask us about anything.',
      'communityIcon': './assets/images/GoogleLogo.png',
    },
    {
      'communityName': 'r/Artists',
      'communityDescription': 'A community for passionate artists where they can explore a whole new world.',
      'communityIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'communityName': 'r/FIHateSoftware',
      'communityDescription': 'Mayyetin abou el software 3ala mayyetin abou el project.',
      'communityIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },

  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: communities.length,
            itemBuilder: (context, index) {
              return CommunityElement(
                communityName: communities[index]['communityName'],
                communityDescription:communities[index]['communityDescription'], 
                communityIcon: communities[index]['communityIcon'],
                );
            }
          ),
        ],
      ), 
    );
  }
}

/* TO DOS :
1) akhod boolean el community da followed walla laa w 3ala asaso ba-render el button
2) mock service  */