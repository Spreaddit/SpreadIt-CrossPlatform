import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/people_elemet.dart';


class PeoplePageView extends StatefulWidget {
  const PeoplePageView({Key? key}) : super(key: key);

  @override
  State<PeoplePageView> createState() => _PeoplePageViewState();
}

class _PeoplePageViewState extends State<PeoplePageView> {

  List users = 
  [
    {
      'username': 'u/FlutterEnthusiat',
      'userIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'username': 'u/DartWizard',
      'userIcon': './assets/images/GoogleLogo.png',
    },
    {
      'username': 'u/MohandesKa7yan',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'u/TheDarkWeeb',
      'userIcon': './assets/images/GoogleLogo.png',
    },
    {
      'username': 'u/DepressedArtist',
      'userIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'username': 'u/SoftwareHater',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'u/FlutterEnthusiat',
      'userIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'username': 'u/DartWizard',
      'userIcon': './assets/images/GoogleLogo.png',
    },
    {
      'username': 'u/MohandesKa7yan',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'u/TheDarkWeeb',
      'userIcon': './assets/images/GoogleLogo.png',
    },
    {
      'username': 'u/DepressedArtist',
      'userIcon': './assets/images/LogoSpreadIt.png',
    },
    {
      'username': 'u/SoftwareHater',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
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
            itemCount: users.length,
            itemBuilder: (context, index) {
              return PeopleElement(
                username: users[index]['username'],
                userIcon: users[index]['userIcon'],
              );
            }
          ),
        ],
      ), 
    );
  }
}