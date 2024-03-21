import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/widgets/home_page_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: HomePageDrawer(),
    );
  }
}
