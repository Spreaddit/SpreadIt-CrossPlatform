import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../discover_communities/data/community.dart';

class ActiveCommunity extends StatelessWidget {
  final Community community;

  ActiveCommunity({
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double photosize = kIsWeb
        ? screenHeight * 0.045
        : (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.08;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
              community.backgroundImage!,
              fit: BoxFit.cover,
              width: kIsWeb ? screenHeight * 0.35 : screenWidth * 0.4,
              height: kIsWeb ? screenWidth * 0.05 : screenHeight * 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: kIsWeb ? screenHeight * 0.12 : screenWidth * 0.1),
                    child: CircleAvatar(
                      radius: photosize,
                      backgroundImage: NetworkImage(community.image!),
                    ),
                  ),
                  SizedBox(height: kIsWeb ? screenHeight * 0.01 : 8),
                  Text(
                    'r/${community.name}',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kIsWeb ? screenHeight * 0.007 : 4),
                  Text(
                    '${community.membersCount} members',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
